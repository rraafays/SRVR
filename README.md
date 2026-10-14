# SRVR

NixOS configuration for the media server (Transmission, slskd, beets, `/away/main`).

## Clone

```bash
git clone --recurse-submodules https://github.com/rraafays/SRVR.git
cd SRVR
cp secrets.nix.example secrets.nix
```

Edit `secrets.nix` (gitignored) before `nixos-rebuild`.

## Layout

| Path | Role |
| ---- | ---- |
| `configuration.nix` | Host boot, network, primary user, module imports |
| `hardware-configuration.nix` | Disks, firmware |
| `secrets.nix` | Local only: slskd credentials (see example) |
| `src/common` | [`common.nix`](https://github.com/rraafays/common.nix) |
| `src/system` | [`system.nix`](https://github.com/rraafays/system.nix) |
| `src/shell` | [`shell.nix`](https://github.com/rraafays/shell.nix) |
| `src/editor` | [`editor.nix`](https://github.com/rraafays/editor.nix) |
| `src/beets` | [`beets.nix`](https://github.com/rraafays/beets.nix) |
| `src/transmission` | [`transmission.nix`](https://github.com/rraafays/transmission.nix) |
| `src/slskd` | [`slskd.nix`](https://github.com/rraafays/slskd.nix) (Soulseek, not torrents) |
| `src/storage` | [`storage.nix`](https://github.com/rraafays/storage.nix) |
| `src/media-tools` | [`media-tools.nix`](https://github.com/rraafays/media-tools.nix) |

Host enables `services.beets`, `services.transmissionClient`, `services.slskdClient`, `services.storage`, and `services.mediaTools`. Desktop-oriented pieces of `system.nix` (PipeWire, printing, libinput) are forced off on this host.

## Deploy

Point NixOS at this directory (e.g. `/etc/nixos` symlink or channel install) and run `sudo nixos-rebuild switch`.

Submodule updates:

```bash
git submodule update --init --recursive
```
