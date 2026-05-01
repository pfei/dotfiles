# .dotfiles

My personal configuration files for a productive Linux development environment. This repository centralizes my settings for **Zsh**, **Tmux**, and **Pandoc** templates.

## 🚀 Features at a Glance

### 🐚 Zsh (Oh My Zsh)

A powerhouse Zsh setup with dynamic environment handling:

- **Adaptive Themes**: Automatically switches to the `refined` theme on servers (detects `/etc/is_server`) and uses `arrow` for local sessions.
- **Language Integration**: Full support for `nvm` (Node), `pyenv` (Python), `Go`, and `Deno`.
- **Python Workflow**: Seamless `virtualenvwrapper` integration via `pyenv`.
- **UI Enhancements**: Custom steady yellow underline cursor that resets on exit.

### 🖥️ Tmux

Terminal multiplexer configured for ergonomics and speed:

- **Prefix**: Remapped to `Ctrl-a` for easier reach.
- **Navigation**: Seamless pane switching with `Alt + Arrow Keys` (no prefix required).
- **Copy Mode**: `vi` keybindings enabled with system clipboard integration (`xclip`).
- **Persistence**: New panes and windows automatically open in the current working directory.

---

## 🛠️ Custom Functions & Aliases

### Shell Utilities

| Command | Description                                                         |
| :------ | :------------------------------------------------------------------ |
| `h`     | Advanced history search (e.g., `h 50` or `h keyword`).              |
| `lsym`  | Lists all symbolic links in the directory with color-coded targets. |
| `lst`   | Displays the 5 most recently modified files (e.g., `lst 10`).       |

### Workflow & Multimedia

- **`trn` (tmux_run_and_notify)**: Executes a command and displays its duration in the Tmux status bar upon completion.
- **`trs` (tmux_restore_status)**: Quickly restores the original Tmux status bar.
- **`bestvideo360`**: Optimized `yt-dlp` alias to download YouTube videos at 360p while bypassing mobile client restrictions.
- **`obs`**: Launches Obsidian (Flatpak) in the background.
- **`jrnl` / `jrnlpdf`**: Custom scripts for journaling and Markdown-to-PDF conversion.

---

## 📂 Repository Structure

```text
.
├── zsh/
├── tmux/
├── pandoc/
│   └── templates/
├── themes/
│   └── Dracula-Yad/
└── README.md
```

---

## ⚙️ Installation

These dotfiles are managed via manual symbolic links for maximum transparency and zero dependencies.

1. **Clone the repository**:
   git clone https://github.com/pfei/.dotfiles.git ~/.dotfiles

2. **Create Symbolic Links**:
   ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc
   ln -sf ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

3. **Core Dependencies**:
   - `oh-my-zsh`
   - `tmux`
   - `yt-dlp` & `ffmpeg` (for video aliases)
   - `xclip` (for Tmux clipboard sharing)
   - `pyenv` / `nvm` / `deno`

---

_Last updated: May 2026_
