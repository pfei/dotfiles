#!/usr/bin/env zsh
echo "🔗 Linking Helix config..."
mkdir -p "$HOME/.config/helix"
ln -sf "${0:a:h}/config.toml" "$HOME/.config/helix/config.toml"

# Set NULL_GLOB locally to avoid errors if no match is found
# This is more shfmt-friendly than the (N) inline modifier
setopt local_options nullglob

appimages=($HOME/.local/bin/helix-*-x86_64.AppImage)

if [[ -e ${appimages[1]} ]]; then
  ln -sf "${appimages[1]}" "$HOME/.local/bin/hx"
  echo "✅ Helix symlinked: ${appimages[1]:t} → hx"
else
  echo "⚠️  No Helix AppImage found in ~/.local/bin. Skipping hx symlink."
fi
