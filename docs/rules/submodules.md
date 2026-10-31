# Git submodules (`src/`)

Importable Nix modules live in **separate GitHub repos** (`rraafays/<name>.nix`) and are wired into this host as submodules under **`src/<name>/`**.

| Submodule path | Remote repo |
| -------------- | ----------- |
| `src/common` | [common.nix](https://github.com/rraafays/common.nix) |
| `src/system` | [system.nix](https://github.com/rraafays/system.nix) |
| `src/shell` | [shell.nix](https://github.com/rraafays/shell.nix) |
| `src/editor` | [editor.nix](https://github.com/rraafays/editor.nix) |
| `src/beets` | [beets.nix](https://github.com/rraafays/beets.nix) |
| `src/transmission` | [transmission.nix](https://github.com/rraafays/transmission.nix) |
| `src/slskd` | [slskd.nix](https://github.com/rraafays/slskd.nix) |
| `src/storage` | [storage.nix](https://github.com/rraafays/storage.nix) |
| `src/media-tools` | [media-tools.nix](https://github.com/rraafays/media-tools.nix) |

## Clone and update

```bash
git clone --recurse-submodules https://github.com/rraafays/SRVR.git
cd SRVR
```

Existing clone without submodules:

```bash
git submodule update --init --recursive
```

Pull host and move submodule pointers:

```bash
git pull
git submodule update --init --recursive
```

Work inside one module (commit in the **module repo**, then bump the host pointer):

```bash
cd src/transmission
git checkout -b my-change
# edit, commit, push to github.com/rraafays/transmission.nix
cd ../..
git add src/transmission
git commit -m "Bump transmission.nix"
```

## Add modules to another host repo

Use the same paths as this project: submodule checkout at **`src/<name>/`**, Nix import **`./src/<name>`**. Shared modules match [X230T](https://github.com/rraafays/X230T); server modules are listed in the root [README.md](../../README.md).
