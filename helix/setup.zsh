#!/usr/bin/env zsh
echo "🔗 Linking Helix config..."
mkdir -p "$HOME/.config/helix"
ln -sf "${0:a:h}/config.toml" "$HOME/.config/helix/config.toml"
