export ZSH="$HOME/.oh-my-zsh"

# --- Theme Selection ---
if [[ -f /etc/is_server ]]; then
    ZSH_THEME="refined"
else
    ZSH_THEME="arrow"
fi

plugins=(git)
source $ZSH/oh-my-zsh.sh

# --- Source modular config ---
ZSH_CONFIG_DIR="$HOME/.dotfiles/zsh"

source "$ZSH_CONFIG_DIR/exports.zsh"
source "$ZSH_CONFIG_DIR/functions.zsh"
source "$ZSH_CONFIG_DIR/aliases.zsh"

# --- Tool Initializations (must be after exports) ---
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Virtualenvwrapper (after pyenv init)
export VIRTUALENVWRAPPER_PYTHON=$(pyenv which python)
source $(pyenv root)/versions/$(pyenv version-name)/bin/virtualenvwrapper.sh

# --- UI / Cursor Setup ---
cursor_color() {
  echo -ne '\e]12;#F9E2AE\a'
  echo -ne '\e[4 q'
}
precmd_functions+=(cursor_color)
zle-line-finish() { echo -ne '\e[0 q' }
zle -N zle-line-finish
cursor_color

# --- Autoloads ---
fpath=( ~/.zsh_autoload_functions $fpath )
autoload -Uz load_google_api_key