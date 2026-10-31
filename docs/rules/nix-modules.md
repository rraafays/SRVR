# Nix modules

## Machine-only (`configuration.nix`)

- `boot`, hostname, wireless/network setup, primary user (this host), host-only package additions
- Overrides for shared modules (e.g. force PipeWire/printing off when `./src/system` is imported)

## System fragments (`system/`)

Purpose-named files: channel auto-upgrade, locale, openssh, optional desktop services (PipeWire, printing, …). SRVR typically imports `./src/system` and disables desktop services on the host.

## Elsewhere

`hardware-configuration.nix`: disks, firmware

## common (`src/common`, repo `common.nix`)

- Imports Home Manager (`fetchTarball` + `"${home-manager}/nixos"`)
- `home-manager.backupFileExtension`, primary-user HM `stateVersion`
- Options: `common.username`, `common.email`, `common.home.stateVersion`

Import **`./src/common`** before other HM feature modules on this host. See [submodules.md](submodules.md).

## Feature modules (under `src/`)

Shared: `shell`, `editor`, `system`. Server-specific: `beets`, `transmission`, `slskd`, `storage`, `media-tools`.

Per-module minimum imports and owned stack: **[modules-ootb.md](modules-ootb.md)**.

- Use `config.common.username`; no hardcoded login names
- Do not import Home Manager themselves

## Import enables; host overrides

A feature submodule listed in `configuration.nix` **`imports`** is **on**. The host file is for machine-specific **overrides** (paths, secrets, disabling PipeWire), hardware, and identity — not for `services.<name>.enable = true` on every import.

- Prefer **no enable gate**, or an `enable` option that **defaults to `true`** so import alone activates the stack.
- To turn a stack off, **remove the import** or set `services.<module>.enable = false` if the module exposes opt-out.
- Do not use `lib.mkEnableOption` alone as the only way to activate a feature module (its default is `false`).

## Out of the box (module completeness)

Once a module is listed in `configuration.nix` (with `./src/common` and any imports its README names), it should **deliver what it claims** without the importer wiring extra NixOS or HM attrs for that concern.

- **Own the stack** — e.g. `shell` sets fish, login shell, and HM shell config.
- **Duplication is acceptable** — repeated `users.groups.downloads`, split HM blocks, or overlapping attrs across modules are fine when each module stays self-contained and Nix merges cleanly.
- **Still centralise identity** — `common.username`, `common.email`, and `common.home.stateVersion` stay in `common/`; do not copy those defaults into feature modules.
- **Build is the gate** — if the full system evaluates and builds, prefer clarity and module boundaries over deduplicating every line.

## Home Manager split

On the laptop host, git identity on HM lives in `user/default.nix`. SRVR does not import `user/`; use HM in `shell` / `editor` as those modules define.
