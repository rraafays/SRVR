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
| `configuration.nix` | Host imports, boot, network, users, media services |
| `hardware-configuration.nix` | Disks, firmware |
| `beets.nix` | Beets music library under `/away/main/Music` |
| `subliminal.nix` | Package overlay for subliminal |
| `secrets.nix` | Local only: slskd credentials (see example) |
| `src/common` | Submodule [`common.nix`](https://github.com/rraafays/common.nix) |
| `src/shell` | Submodule [`shell.nix`](https://github.com/rraafays/shell.nix) |
| `src/editor` | Submodule [`editor.nix`](https://github.com/rraafays/editor.nix) |

## Deploy

Point NixOS at this directory (e.g. `/etc/nixos` symlink or flake-less channel install) and run `sudo nixos-rebuild switch`.

Submodule updates:

```bash
git submodule update --init --recursive
```
