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

Feature stacks under `src/beets`, `src/transmission`, `src/slskd`, `src/storage`, and `src/media-tools` are **on when imported**; the host file sets overrides only (paths, secrets, disabling desktop bits from `system.nix`). See [docs/rules/nix-modules.md](docs/rules/nix-modules.md).

This host forces `services.printing`, `services.libinput`, and `services.pipewire` off. The primary account comes from `common.username` in `configuration.nix` (wheel, NetworkManager); there is no `user/` submodule so the server stays free of desktop app packages from `user.nix`.

## Deploy

Point NixOS at this directory (e.g. `/etc/nixos` symlink or channel install) and run `sudo nixos-rebuild switch`.

Submodule updates:

```bash
git submodule update --init --recursive
```
