#!/usr/bin/env zsh

# --- MATE Terminal Configuration ---
DCONF_PROFILE_DIR="/org/mate/terminal/profiles"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ -f "$SCRIPT_DIR/catppucin.dconf" ]]; then
  # Reset old profiles to ensure a clean state
  dconf reset -f "$DCONF_PROFILE_DIR/"

  # Load the complete Catppuccin profiles pack
  dconf load "$DCONF_PROFILE_DIR/" < "$SCRIPT_DIR/catppucin.dconf"

  # Set Catppuccin Mocha as the default global system profile
  gsettings set org.mate.terminal.global default-profile 'Catppuccin-mocha'
  gsettings set org.mate.terminal.global profile-list "['Catppuccin-mocha', 'default']"
fi
