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

# Ensure the local bin directory exists
mkdir -p "$HOME/.local/bin"

# Automate symlinks for all user binaries/scripts
if [[ -d "./.local/bin" ]]; then
  for bin_file in ./.local/bin/*; do
    if [[ -f "$bin_file" ]]; then
      local bin_name=$(basename "$bin_file")
      # -f forces overwriting existing symlinks, -s makes it symbolic
      ln -sf "$HOME/.dotfiles/.local/bin/$bin_name" "$HOME/.local/bin/$bin_name"
    fi
  done
fi

echo "🎉 Installation complete!"
