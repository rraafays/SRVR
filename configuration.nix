{
  config,
  pkgs,
  lib,
  ...
}:

let
  subliminal = pkgs.callPackage ./subliminal.nix { };
in
{
  imports = [
    ./hardware-configuration.nix
    ./beets.nix
    ./secrets.nix
    ./src/common
    ./src/editor
    ./src/shell
  ];

  common.username = lib.mkDefault "raf";
  common.email = lib.mkDefault "rraf@tuta.io";
  common.home.stateVersion = lib.mkDefault "26.05";

  services.openssh.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "SRVR";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        5030
      ];
      allowedUDPPorts = [
        5030
      ];
    };
  };

  time.timeZone = "Europe/London";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  users = {
    groups.downloads = { };
    users = {
      "raf" = {
        isNormalUser = true;
        description = "raf";
        extraGroups = [
          "networkmanager"
          "wheel"
          "downloads"
        ];
        packages = with pkgs; [ ];
      };
      slskd.extraGroups = [ "downloads" ];
      transmission.extraGroups = [ "downloads" ];
    };
  };

  environment.enableAllTerminfo = true;
  environment.systemPackages = [
    pkgs.nixfmt
    pkgs.fd
    pkgs.unixtools.netstat
    pkgs.btop
    pkgs.hyperfine
    subliminal
    (pkgs.writeShellScriptBin "subliminal-download" ''
      lang="$1"
      find . -type f -not -path '*/.*' \( \
        -iname "*.mkv" -o \
        -iname "*.mp4" -o \
        -iname "*.avi" -o \
        -iname "*.mov" -o \
        -iname "*.webm" \
      \) -exec subliminal download -l "$lang" {} \;
    '')
    (pkgs.writeShellScriptBin "video-info" ''
      find . -type f -not -path '*/.*' \( \
        -iname "*.mkv" -o \
        -iname "*.mp4" -o \
        -iname "*.avi" -o \
        -iname "*.mov" -o \
        -iname "*.webm" \
      \) -exec sh -c '
        file="$1"
        info_file="''${file%.*}-info.txt"

        ${pkgs.ffmpeg}/bin/ffprobe \
          -v error \
          -select_streams v:0 \
          -show_entries stream=codec_name,width,height,pix_fmt,r_frame_rate,bit_rate \
          -show_entries format=duration,size,bit_rate \
          -of default=noprint_wrappers=1 \
          "$file" > "$info_file"
      ' sh {} \;
    '')

    (pkgs.writeShellScriptBin "audio-info" ''
      find . -type f -not -path '*/.*' \( \
        -iname "*.mp3" -o \
        -iname "*.flac" -o \
        -iname "*.wav" -o \
        -iname "*.m4a" -o \
        -iname "*.aac" -o \
        -iname "*.ogg" -o \
        -iname "*.opus" -o \
        -iname "*.wma" \
      \) -exec sh -c '
        file="$1"
        info_file="''${file%.*}-info.txt"

        ${pkgs.ffmpeg}/bin/ffprobe \
          -v error \
          -select_streams a:0 \
          -show_entries stream=codec_name,sample_rate,channels,channel_layout,sample_fmt,bit_rate \
          -show_entries format=duration,size,bit_rate \
          -of default=noprint_wrappers=1 \
          "$file" > "$info_file"
      ' sh {} \;
    '')
  ];

  services.transmission = {
    enable = true;
    openRPCPort = true;
    openFirewall = true;
    settings = {
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "*";
      download-dir = "/away/main/Downloads";
    };
  };

  services.slskd = {
    enable = true;
    openFirewall = true;
    environmentFile = "/etc/slskd/env";
    settings = {
      web.authentication.disabled = true;
      directories.downloads = "/away/main/Downloads";
    };
  };

  systemd.tmpfiles.rules = [
    "d /away/main/Downloads 2775 raf downloads -"
  ];

  systemd.services.transmission.serviceConfig.UMask = lib.mkForce "0002";
  systemd.services.slskd.serviceConfig.UMask = lib.mkForce "0002";

  services.udisks2.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel") &&
          (action.id == "org.freedesktop.udisks2.filesystem-mount-other-seat" ||
           action.id == "org.freedesktop.udisks2.filesystem-unmount-others"))
        return polkit.Result.YES;
    });
  '';

  system.stateVersion = "26.05";
}
