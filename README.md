# vscode-settings

Personal VS Code configuration for Debian (MATE) + Zsh.

> Repo: https://github.com/pfei/vscode-settings

## Setup

```sh
git clone https://github.com/pfei/vscode-settings ~/.vscode-settings
cd ~/.vscode-settings
chmod +x vscode-setup.sh
./vscode-setup.sh
```

The script creates symlinks from `~/.config/Code/User/` to this repo and installs all extensions.

## Keybindings

| Shortcut | Action |
|---|---|
| `Ctrl+L` | Toggle line numbers on/off |
| `Ctrl+Alt+V` | Toggle Vim mode |
| `Shift+Alt+F` | Format document |
| `Ctrl+K Ctrl+Shift+4` | Fold block under cursor |
| `Ctrl+K Ctrl+Shift+5` | Unfold block under cursor |

## Extensions

See [`extensions.txt`](./extensions.txt).

Notable: Ruff (Python formatter/linter), Pylance, ESLint, Prettier, VSCodeVim, Settings Cycler.

## License

MIT — see [`LICENSE`](./LICENSE).
