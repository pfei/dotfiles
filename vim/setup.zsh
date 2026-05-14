#!/usr/bin/env zsh
echo "🔗 Linking Vim config..."
ln -sf "${0:a:h}/.vimrc" "$HOME/.vimrc"
