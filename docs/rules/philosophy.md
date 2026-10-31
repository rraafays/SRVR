# Philosophy

## What this repo is

- NixOS configuration for the **SRVR** media host (Transmission, slskd, beets, `/away/main`).
- **Channel-based** upgrades, not flakes, unless explicitly requested later.
- **`configuration.nix`** lists module imports; machine-specific settings live in **`configuration.nix`** (boot, network, primary user) and **`hardware-configuration.nix`**.
- **Importable modules** as git submodules under **`src/`** (`common.nix`, `shell.nix`, server-specific repos, …) for reuse on other NixOS hosts (e.g. [X230T](https://github.com/rraafays/X230T)).

## Design goals

- **`common/`** — Home Manager bootstrap, `common.username`, `common.email`, `common.home.stateVersion`.
- **Portable modules** — feature dirs own their behaviour end-to-end when imported; disk, hostname, and machine-only attrs stay on the host. Some duplication across modules is fine if each module “just works.”
- **Explicit HM wiring** — only `common/` imports `"${home-manager}/nixos"`; feature modules attach to `home-manager.users.<username>`.
- **Lean docs** — READMEs describe current behaviour; commit-worthy decisions in **MADR** under `docs/decisions/`.
- **No desktop `user/` module on this host** — the laptop `user.nix` bundle is omitted so the server does not pull GNOME app packages; the host defines a minimal normal user (wheel, NetworkManager).

## Out of scope by default

- Flakes unless asked.
- Capture/export scripts or comments in code unless requested.
