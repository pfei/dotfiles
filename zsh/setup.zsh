#!/usr/bin/env zsh

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "🔗 Linking Zsh and Tmux configs..."
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# Create local folders if they don't exist
mkdir -p "$HOME/.zsh_autoload_functions"

AUTOLOAD_FUNC="$HOME/.zsh_autoload_functions/load_google_api_key"
if [[ ! -f "$AUTOLOAD_FUNC" ]]; then
  cat > "$AUTOLOAD_FUNC" << 'EOF'
# Autoload function: load_google_api_key
# Loads GOOGLE_API_KEY from ~/.google_api_key (not tracked in git)
if [[ -f "$HOME/.google_api_key" ]]; then
  export GOOGLE_API_KEY="$(cat "$HOME/.google_api_key")"
else
  echo "⚠  ~/.google_api_key not found. GOOGLE_API_KEY not set."
fi
EOF
  echo "✅ Created stub: ~/.zsh_autoload_functions/load_google_api_key"
else
  echo "ℹ️  load_google_api_key already exists, skipping."
fi

echo "✅ Zsh and Tmux configs linked."
