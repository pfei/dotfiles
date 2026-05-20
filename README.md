# 🚀 dotfiles

My personal configuration files for a productive Linux development environment.
This repository centralizes my settings for Zsh, Tmux, VS Code, Helix, Vim, and Pandoc.


## 🛠️ Manual Prerequisites

Before running the automation, ensure the following are installed:

### 1. System Packages & Python Build Dependencies
Essential for general workflows and compiling isolated Python environments with `pyenv`:
```bash
sudo apt update && sudo apt install -y curl git zsh tmux xclip yad shfmt \
build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
libsqlite3-dev libncursesw5-dev xz-utils tk-dev libxml2-dev \
libxmlsec1-dev libffi-dev liblzma-dev
```

### 2. Base Frameworks
```bash
# Oh My Zsh
sh -c "$(curl -fsSL [https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh](https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh))"

# Pyenv & plugins
curl [https://pyenv.run](https://pyenv.run) | bash
```

### 3. Server Configuration (Optional)
If setting up a headless environment / VPS, flag the machine as a server to switch the Zsh prompt theme automatically to `refined` instead of the local `arrow` theme:
```bash
sudo touch /etc/is_server
```

### 4. Helix Editor (AppImage)
Download the official AppImage and place it in the local binaries directory. The installation script will automatically detect and manage it (including extracting it if FUSE is unavailable on a headless server):
```bash
mkdir -p ~/.local/bin
# Download the AppImage from [https://github.com/helix-editor/helix/releases](https://github.com/helix-editor/helix/releases)
# and place it inside ~/.local/bin/
```


## ⚙️ Installation

You can clone this repository anywhere (e.g., `~/src/dotfiles`). The scripts adapt dynamically to create the proper symlinks and isolate settings according to your environment (Desktop vs Headless VPS).

```bash
git clone [https://github.com/pfei/dotfiles.git](https://github.com/pfei/dotfiles.git) ~/src/dotfiles
cd ~/src/dotfiles
./install.py
```

The script iterates over all modules (`git`, `zsh`, `tmux`, `vscode`, `helix`, `vim`, `pandoc`, `themes`, `mate-terminal`), automatically skipping GUI modules on headless setups.

### 🐍 Post-Installation: Python Environment Integration
To complete your Python isolation setup and make the `.zshrc` workflow fully operational, install your target Python version and initialize `virtualenvwrapper` hooks inside it:

For example with python 3.13.13:

```bash
# 1. Install and set your working Python version
pyenv install 3.13.13
pyenv global 3.13.13

# 2. Bind virtualenvwrapper inside the isolated version
pip install virtualenvwrapper

# 3. Reload your shell configuration
omz reload
```

### 🔒 Post-Installation: Git Identity
Since this repository is public, it stays strictly anonymous. Do not forget to configure your private user information locally on the machine (saved in `~/.gitconfig` outside the repository tracking):
```bash
git config --global user.name "Pierre Feilles"
git config --global user.email "4628744+pfei@users.noreply.github.com"
```


## Features at a Glance

### 🐚 Zsh (Oh My Zsh)
A modular Zsh setup with dynamic environment handling:
- **Modular Architecture**: Configuration split into exports, aliases, and functions.
- **Adaptive Themes**: Uses `refined` (e.g., `~ ❯ pierre@srv712773`) on servers via `/etc/is_server`, and `arrow` (e.g., `~ ➤`) on local machines.
- **Language Integration**: nvm, pyenv, Go, Deno.
- **Python Workflow**: pyenv for Python version management, virtualenvwrapper for lightweight virtual environments.
- **UI**: Custom steady yellow underline cursor that resets on exit.

### 🔒 Local Overrides
The `.zshrc` configuration dynamically checks for and sources `~/.zshrc.local` right before initializing the cursor UI. This provides a clean point of extension to inject private paths, professional/personal aliases, or specific overrides without polluting the public repository tracking.

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
- **AppImage Management**: Automatically symlinks `hx` directly to the AppImage on desktop environments, or extracts it cleanly into a FUSE-less standalone wrapper on headless servers.
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
│   ├── .zshrc             # Main entry point
│   ├── aliases.zsh        # Custom shortcuts
│   ├── exports.zsh        # PATH and env variables
│   ├── functions.zsh      # Utilities and helpers
│   └── setup.py           # Symlinks + autoload stub
├── tmux/
│   ├── .tmux.conf          # Tmux configuration
│   └── setup.py
├── vscode/
│   ├── settings.json
│   ├── keybindings.json
│   ├── extensions.txt
│   ├── snippets/
│   └── setup.py
├── helix/
│   ├── config.toml
│   └── setup.py            # Symlinks config + hx AppImage/Wrapper
├── vim/
│   ├── .vimrc
│   └── setup.py
├── pandoc/
│   ├── templates/          # LaTeX templates
│   └── setup.py
├── themes/
│   ├── Dracula-Yad/        # Custom yad GTK theme
│   └── setup.py
├── install.py              # Global installer
├── .ignore                 # Show dotfiles in Helix file picker
└── LICENSE
```

---

## ⚖️ License
MIT License — see LICENSE for details.

Last updated: May 2026
