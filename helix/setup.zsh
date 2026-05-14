#!/usr/bin/env zsh
echo "🔗 Linking Helix config..."
mkdir -p "$HOME/.config/helix"
ln -sf "${0:a:h}/config.toml" "$HOME/.config/helix/config.toml"

# Create a fixed symlink for the AppImage
# This assumes the AppImage is in ~/.local/bin
ln -sf $HOME/.local/bin/helix-*-x86_64.AppImage $HOME/.local/bin/hx
