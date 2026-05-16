#!/usr/bin/env zsh

# Root directory of your dotfiles
DOTFILES_DIR="${0:a:h}"

echo "🏗️  Starting Global Dotfiles Installation..."

# List of modules to setup
configs=("zsh" "tmux" "vscode" "helix" "vim" "pandoc" "themes" "mate-terminal")

for config in $configs; do
  SETUP_SCRIPT="$DOTFILES_DIR/$config/setup.zsh"

  if [[ -f "$SETUP_SCRIPT" ]]; then
    echo "─── Installing $config ───"
    zsh "$SETUP_SCRIPT"
  else
    echo "⚠️  No setup.zsh found in $config/"
  fi
done

echo "🎉 Installation complete!"
