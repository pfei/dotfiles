#!/usr/bin/env zsh

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "🔗 Linking Zsh and Tmux configs..."
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Create local folders if they don't exist
mkdir -p "$HOME/.zsh_autoload_functions"

echo "✅ Zsh and Tmux configs linked."
