#!/usr/bin/env zsh
echo "🔗 Linking Helix config..."
mkdir -p "$HOME/.config/helix"
ln -sf "${0:a:h}/config.toml" "$HOME/.config/helix/config.toml"

# Create a fixed symlink for the AppImage
# Globbing with (N) to return an empty list if no match found
appimages=($HOME/.local/bin/helix-*-x86_64.AppImage(N))

if [[ -e $appimages[1] ]]; then
    ln -sf "$appimages[1]" "$HOME/.local/bin/hx"
    echo "✅ Helix symlinked: ${appimages[1]:t} → hx"
else
    echo "⚠️  No Helix AppImage found in ~/.local/bin. Skipping hx symlink."
fi