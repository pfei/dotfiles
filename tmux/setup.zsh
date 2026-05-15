#!/usr/bin/env zsh
echo "🔗 Linking Tmux config..."
ln -sf "${0:a:h}/.tmux.conf" "$HOME/.tmux.conf"
