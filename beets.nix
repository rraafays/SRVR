{
  config,
  pkgs,
  lib,
  ...
}:
let
  beetsConfig = pkgs.writeText "config.yaml" ''
    directory: /away/main/Music
    threaded: yes
    original_date: yes
    import:
        write: yes
        copy: yes
        move: no
        log: /away/main/Music/.beets/import.log
    plugins:
        - musicbrainz
        - discogs
        - fetchart
        - embedart
        - hook
        - edit
    art_filename: max_cover
    embedart:
        auto: yes
    fetchart:
        deinterlace: yes
        cover_format: JPEG
    paths:
        default: $albumartist/$year - $album%aunique{}/$track - $title
        singleton: Non-Album/$artist/$year - $title
        comp: Compilations/$year - $album%aunique{}/$track - $title
    hook:
        hooks:
            - event: album_imported
              command: 'magick "{album.path}/max_cover.jpg" -resize 200x200^ -gravity center -extent 200x200 -interlace none "{album.path}/cover.jpg"'
  '';
in
{
  environment.systemPackages = [
    pkgs.beets
  ];

  systemd.tmpfiles.rules = [
    "d /away/main/Music/.beets 0755 raf downloads -"
    "L+ /away/main/Music/.beets/config.yaml - - - - ${beetsConfig}"
  ];

  environment.variables = {
    BEETSDIR = "/away/main/Music/.beets/";
  };
}
