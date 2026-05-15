# 🚀 .dotfiles

My personal configuration files for a productive Linux development environment.
This repository centralizes my settings for Zsh, Tmux, VS Code, Helix, Vim, and Pandoc.


## 🛠️ Manual Prerequisites

Before running the automation, ensure the following are installed:

```bash
# Essential system packages
sudo apt update && sudo apt install -y curl git zsh tmux xclip yad shfmt

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Helix Editor (AppImage)
# Download from https://github.com/helix-editor/helix/releases
# Place the AppImage in ~/.local/bin/ — setup will symlink it to `hx`
mkdir -p ~/.local/bin
```


## ⚙️ Installation

```bash
git clone https://github.com/pfei/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.zsh
./install.zsh
```

The script iterates over all modules (`zsh`, `tmux`, `vscode`, `helix`, `vim`, `pandoc`, `themes`) and runs each `setup.zsh` automatically.


## Features at a Glance

### 🐚 Zsh (Oh My Zsh)
A modular Zsh setup with dynamic environment handling:
- **Modular Architecture**: Configuration split into exports, aliases, and functions.
- **Adaptive Themes**: Switches to `refined` on servers, `arrow` locally.
- **Language Integration**: nvm, pyenv, Go, Deno.
- **Python Workflow**: pyenv for Python version management, virtualenvwrapper for lightweight virtual environments..
- **UI**: Custom steady yellow underline cursor that resets on exit.

### 🖥️ Tmux
Terminal multiplexer configured for ergonomics and speed:
- **Prefix**: Remapped to `Ctrl-a`.
- **Navigation**: Pane switching with `Alt + Arrow Keys`, window switching with `Ctrl + PageUp/Down`.
- **Copy Mode**: vi keybindings with system clipboard integration (xclip).
- **Persistence**: New panes/windows open in the current working directory.

### 💻 VS Code
- **Centralized Config**: Settings, keybindings, and snippets in one directory.
- **Automation**: One-command deployment of symlinks and extensions.
- **Smart Formatting**: Auto-format shell scripts on save via shfmt, Python via Ruff.
- **Vim Integration**: Optimized Vim keybindings via vscodevim.

### 🪨 Helix
- **Configuration**: `helix/config.toml` → `~/.config/helix/config.toml`
- **AppImage**: `hx` symlink created automatically from `helix-*-x86_64.AppImage` in `~/.local/bin/`
- **Hidden Files**: `.ignore` ensures dotfiles are visible in the file picker (`Space + f`).

### 📝 Vim
- **Configuration**: `vim/.vimrc` → `~/.vimrc`
- Relative line numbers, persistent undo, Space as leader key.

### 📄 Pandoc
- **Templates**: `pandoc/templates/` → `~/.local/share/pandoc/templates/`
- Clean LaTeX journal template for PDF export.
### 🎨 Themes
- **Dracula-Yad**: Custom Dracula variant for `yad` dialogs → `~/.themes/`

---


## 🛠️ Custom Functions & Aliases

### Shell Utilities
- `h`: History search — no args shows last 20, number shows N lines, string greps.
- `lsym`: Lists symlinks in current directory with color-coded targets.
- `lst`: Shows the 5 most recently modified files.
- `dumpcode`: Dumps the full codebase to a text file for LLM analysis, skipping locks and binaries.
- `gitscan`: Scans git history for secrets using `gitleaks`. It runs in redacted mode to safely display results on public screens.

### Workflow & Multimedia
- `trn` / `trs`: Run a command and display its duration in the Tmux status bar.
- `bv360`: Download a YouTube video at 360p via yt-dlp.
- `yta`: Extract best-quality audio from YouTube with metadata and thumbnail.



## 📂 Repository Structure
```
.
├── zsh/
│   ├── .zshrc              # Main entry point
│   ├── aliases.zsh         # Custom shortcuts
│   ├── exports.zsh         # PATH and env variables
│   ├── functions.zsh       # Utilities and helpers
│   └── setup.zsh           # Symlinks + autoload stub
├── tmux/
│   ├── .tmux.conf          # Tmux configuration
│   └── setup.zsh
├── vscode/
│   ├── settings.json
│   ├── keybindings.json
│   ├── extensions.txt
│   ├── snippets/
│   └── setup.zsh
├── helix/
│   ├── config.toml
│   └── setup.zsh           # Symlinks config + hx AppImage
├── vim/
│   ├── .vimrc
│   └── setup.zsh
├── pandoc/
│   ├── templates/          # LaTeX templates
│   └── setup.zsh
├── themes/
│   ├── Dracula-Yad/        # Custom yad GTK theme
│   └── setup.zsh
├── install.zsh             # Global installer
├── .ignore                 # Show dotfiles in Helix file picker
└── LICENSE
```

---

## ⚖️ License
MIT License — see LICENSE for details.

Last updated: May 2026