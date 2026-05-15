#!/usr/bin/env zsh

DOTFILES_PANDOC_DIR="$(cd "$(dirname "$0")" && pwd)"
PANDOC_TEMPLATES_DIR="$HOME/.local/share/pandoc/templates"

echo "🔗 Linking Pandoc templates..."
mkdir -p "$PANDOC_TEMPLATES_DIR"

for template in "$DOTFILES_PANDOC_DIR"/templates/*.latex; do
  ln -sf "$template" "$PANDOC_TEMPLATES_DIR/${template:t}"
  echo "✅ Linked: ${template:t}"
done

echo "✅ Pandoc templates linked."
