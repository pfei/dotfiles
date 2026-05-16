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

echo "⚙️ Applying MATE interface settings..."
# Apply MATE interface theme settings
gsettings set org.mate.interface gtk-theme 'Dracula'
gsettings set org.mate.interface icon-theme 'Mint-Y'
gsettings set org.mate.interface buttons-have-icons true
gsettings set org.mate.interface menus-have-icons true
gsettings set org.mate.interface toolbar-icons-size 'large-toolbar'

# Apply MATE window manager (Marco) settings
gsettings set org.mate.Marco.general theme 'Dracula'
echo "✅ MATE settings applied."
