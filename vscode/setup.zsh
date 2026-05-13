#!/bin/zsh

# Get the absolute path of the directory where this script is located
# ${0:a:h} is a Zsh-specific modifier: (a)bsolute path, (h)ead (dirname)
DOTFILES_VSCODE_DIR="${0:a:h}"
VSCODE_USER_DIR="$HOME/.config/Code/User"

echo "🔧 Starting VS Code setup..."

# Ensure the target configuration directory exists
if [ ! -d "$VSCODE_USER_DIR" ]; then
  echo "Creating VS Code user directory: $VSCODE_USER_DIR"
  mkdir -p "$VSCODE_USER_DIR"
fi

# Clean up existing symlinks or files to avoid conflicts/nested links
rm -f "$VSCODE_USER_DIR/settings.json"
rm -f "$VSCODE_USER_DIR/keybindings.json"
rm -rf "$VSCODE_USER_DIR/snippets"

# Create new symlinks pointing to the unified .dotfiles repository
echo "🔗 Creating symlinks..."
ln -s "$DOTFILES_VSCODE_DIR/settings.json" "$VSCODE_USER_DIR/settings.json"
ln -s "$DOTFILES_VSCODE_DIR/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"

# Now snippets are inside the vscode directory
if [ -d "$DOTFILES_VSCODE_DIR/snippets" ]; then
  ln -s "$DOTFILES_VSCODE_DIR/snippets" "$VSCODE_USER_DIR/snippets"
  echo "✅ Snippets linked."
else
  echo "ℹ️  No snippets directory found in $DOTFILES_VSCODE_DIR. Skipping."
fi

echo "✅ Configuration files linked successfully."

# Install extensions from extensions.txt if it exists
EXTENSIONS_FILE="$DOTFILES_VSCODE_DIR/extensions.txt"
if [ -f "$EXTENSIONS_FILE" ]; then
  echo "📦 Installing extensions..."
  grep -v '^#' "$EXTENSIONS_FILE" | grep -v '^$' | xargs -L 1 code --install-extension
  echo "✅ Extensions installation process completed."
else
  echo "ℹ️  No extensions.txt found. Skipping installation."
fi

echo "🚀 VS Code setup finished!"
