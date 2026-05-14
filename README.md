# 🚀 .dotfiles

My personal configuration files for a productive Linux development environment. This repository centralizes my settings for Zsh, Tmux, VS Code, and Pandoc templates.

## Features at a Glance

### 🐚 Zsh (Oh My Zsh)
A modular and powerhouse Zsh setup with dynamic environment handling:
- Modular Architecture: Configuration split into exports, aliases, and functions for better maintainability.
- Adaptive Themes: Automatically switches to the refined theme on servers and uses arrow for local sessions.
- Language Integration: Full support for nvm, pyenv, Go, and Deno.
- Python Workflow: Seamless virtualenvwrapper integration via pyenv.
- UI Enhancements: Custom steady yellow underline cursor that resets on exit.

### 🖥️ Tmux
Terminal multiplexer configured for ergonomics and speed:
- Prefix: Remapped to Ctrl-a for easier reach.
- Navigation: Seamless pane switching with Alt + Arrow Keys.
- Copy Mode: vi keybindings enabled with system clipboard integration (xclip).
- Persistence: New panes and windows automatically open in the current working directory.

### 💻 VS Code
Unified and portable development environment:
- Centralized Config: Settings, keybindings, and snippets grouped in a single directory.
- Automation: Custom Zsh script for one-command deployment of links and extensions.
- Smart Formatting: Auto-format shell scripts on save using shfmt.
- Vim Integration: Optimized Vim keybindings and UI settings.

### Helix 
- **Configuration**: `helix/config.toml` (symlinked to `~/.config/helix/config.toml`)
- **Alias**: `hx` (defined in `zsh/aliases.zsh`)
- **Hidden Files**: Managed via `.ignore` to ensure dotfiles are visible in the file picker (`Space + f`).

---

## 🛠️ Custom Functions & Aliases

### Shell Utilities
- h: Advanced history search with optional line count or keyword filtering.
- lsym: Lists all symbolic links in the directory with color-coded targets.
- lst: Displays the 5 most recently modified files.
- dumpcode: Dumps the codebase into a text file for LLM analysis, automatically excluding locks and binaries.

### Workflow & Multimedia
- trn / trs: Execute commands with duration notifications in the Tmux status bar.
- bv360: Optimized yt-dlp alias to download YouTube videos at 360p.
- yta: One-command YouTube to high-quality audio extraction with metadata and $HOME/Downloads output.
- gitscan: Quick security check for leaked secrets in the git history.


## 📂 Repository Structure

.
├── zsh/
│   ├── .zshrc         # Main entry point
│   ├── aliases.zsh    # Custom shortcuts
│   ├── exports.zsh    # PATH and ENV variables
│   └── functions.zsh  # Logic and utilities
├── vscode/
│   ├── setup.zsh      # Deployment script
│   ├── settings.json  # VS Code user settings
│   ├── extensions.txt # List of required extensions
│   └── snippets/      # Custom code snippets
├── tmux/
│   └── .tmux.conf     # Tmux configuration
├── pandoc/
│   └── templates/     # LaTeX journal templates
├── themes/
│   └── Dracula-Yad/   # Custom Dracula-Yad GTK theme
└── LICENSE            # MIT License


## ⚙️ Installation

### Step 1: Clone the repository
git clone https://github.com/pfei/.dotfiles.git ~/.dotfiles

### Step 2: Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### Step 3: Core Shell Setup
ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

### Step 4: VS Code Setup
Run the dedicated setup script to link configuration files and install extensions:
./vscode/setup.zsh

---

## ⚖️ License
Distributed under the MIT License. See the LICENSE file for more information.

Last updated: May 2026
