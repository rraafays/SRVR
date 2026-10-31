# Module OOTB checklist

Each importable module under `src/` should work on a fresh NixOS install when combined with only the imports listed below (plus host **hardware**: `fileSystems`, `boot.loader`, drivers). Identity comes from **`./common`**; Home Manager is pulled in by `common`, not by feature modules.

| Module | Minimum imports | Owns (out of the box) | Host still required |
| ------ | ----------------- | --------------------- | ------------------- |
| `common` | — | HM tarball, `common.*` options, primary-user HM `stateVersion` | `system.stateVersion` if no other module sets it |
| `system` | optional | auto-upgrade channel, locale, openssh, optional PipeWire/printing, sudo, base packages | boot, disks; SRVR disables desktop services on host |
| `shell` | `common` | fish login shell, HM fish/starship/lsd/direnv | — (defaults `isNormalUser`) |
| `editor` | none | Neovim, LSP/format tools, nerd font, `MANPAGER` | — |
| `beets` | `common` | beets + imagemagick, `BEETSDIR`, library `.beets` layout, `downloads` group | library path override if not default |
| `transmission` | `common` | Transmission daemon, RPC, download dir, `downloads` group | download path override if needed |
| `slskd` | `common` | slskd service, firewall ports, `downloads` group | `secrets.nix` / env file for credentials |
| `storage` | none | udisks2, wheel polkit mount rules | — |
| `media-tools` | none | ffmpeg, subliminal helpers, probe scripts | — |

**Primary user on SRVR:** defined in host `configuration.nix` (`users.users.${config.common.username}`: wheel, NetworkManager). Do not import laptop `user/` unless you want that package bundle.

Duplicated attrs (`downloads` group, fish, `isNormalUser`) across modules are intentional; Nix merges them. Prefer enabling a concern in every module that needs it rather than assuming another import is always present.

See [nix-modules.md](nix-modules.md) (import enables; host overrides only) and [0001-import-enables-feature-modules.md](../decisions/0001-import-enables-feature-modules.md).
