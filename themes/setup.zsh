#!/usr/bin/env zsh

DOTFILES_THEMES_DIR="$(cd "$(dirname "$0")" && pwd)"
GTK_THEMES_DIR="$HOME/.themes"

echo "🔗 Linking GTK themes..."
mkdir -p "$GTK_THEMES_DIR"

for theme_dir in "$DOTFILES_THEMES_DIR"/*/; do
  theme_name="${theme_dir:t}"
  ln -sfn "$theme_dir" "$GTK_THEMES_DIR/$theme_name"
  echo "✅ Linked theme: $theme_name"
done

echo "✅ Themes linked."
