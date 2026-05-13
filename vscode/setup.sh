#!/bin/sh

# Define paths
VSCODE_USER_DIR="$HOME/.config/Code/User"
SETTINGS_DIR="$HOME/.vscode-settings"

# Ensure the VS Code user directory exists
if [ ! -d "$VSCODE_USER_DIR" ]; then
  echo "Error: VS Code user directory does not exist at $VSCODE_USER_DIR"
  exit 1
fi

# Remove existing snippets directory if it exists
if [ -d "$VSCODE_USER_DIR/snippets" ]; then
  rm -rf "$VSCODE_USER_DIR/snippets"
fi

# Create symlinks for settings, keybindings, and snippets
ln -sf "$SETTINGS_DIR/settings.json" "$VSCODE_USER_DIR/settings.json"
ln -sf "$SETTINGS_DIR/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"
ln -sf "$SETTINGS_DIR/snippets" "$VSCODE_USER_DIR/snippets"

echo "Symlinks created successfully!"

# Check if extensions.txt exists
EXTENSIONS_FILE="$SETTINGS_DIR/extensions.txt"
if [ -f "$EXTENSIONS_FILE" ]; then
  echo "Installing extensions from $EXTENSIONS_FILE..."
  cat "$EXTENSIONS_FILE" | xargs -L 1 code --install-extension
  echo "Extensions installed successfully!"
else
  echo "No extensions.txt file found. Skipping extension installation."
fi

echo "VS Code setup completed!"

