export ZSH="$HOME/.oh-my-zsh"

# Dynamically locate the zsh configuration directory, even behind a symlink
export ZSH_CONFIG_DIR="${${(%):-%x}:A:h}"

# --- Theme Selection ---
if [[ -f /etc/is_server ]]; then
  ZSH_THEME="refined"
else
  ZSH_THEME="arrow"
fi

# --- Plugins ---
plugins=(git)

source "$ZSH/oh-my-zsh.sh"

# --- Modular Config ---
source "$ZSH_CONFIG_DIR/exports.zsh"
source "$ZSH_CONFIG_DIR/functions.zsh"
source "$ZSH_CONFIG_DIR/aliases.zsh"

# --- Pyenv ---
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# --- Pipx ---
export PIPX_DEFAULT_PYTHON="$(pyenv which python)"

# --- Virtualenvwrapper ---
export VIRTUALENVWRAPPER_PYTHON="$(pyenv which python)"
_venvwrapper="$(pyenv root)/versions/$(pyenv version-name)/bin/virtualenvwrapper.sh"
if [ -f "$_venvwrapper" ]; then
  source "$_venvwrapper"
else
  echo "⚠ virtualenvwrapper not found for pyenv version $(pyenv version-name)"
fi
unset _venvwrapper

# --- Autoloads ---
fpath=(~/.zsh_autoload_functions $fpath)
autoload -Uz load_google_api_key

# --- Local Overrides ---
# Load local/private configurations if present
if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi

# --- Cursor UI (Always Last) ---
cursor_color() {
  echo -ne '\e]12;#F9E2AE\a'
  echo -ne '\e[4 q'
}

precmd_functions+=(cursor_color)

zle-line-finish() {
  echo -ne '\e[0 q'
}

zle -N zle-line-finish

cursor_color
