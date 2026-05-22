# ==============================================================================
# --- OH MY ZSH ---
# ==============================================================================
export ZSH="$HOME/.oh-my-zsh"

# Dynamically locate the zsh config directory, even behind a symlink
export ZSH_CONFIG_DIR="${${(%):-%x}:A:h}"

# Fallback si un 'source ~/.zshrc' manuel dérègle le comportement de %x
[[ -f "$ZSH_CONFIG_DIR/exports.zsh" ]] || ZSH_CONFIG_DIR="$HOME/.dotfiles/zsh"

# Theme: refined on servers, arrow on local machines
if [[ -f /etc/is_server ]]; then
  ZSH_THEME="refined"
else
  ZSH_THEME="arrow"
fi

plugins=(git)

# ==============================================================================
# --- COMPINIT CACHE (saves ~200-400ms) ---
# ==============================================================================
# Prevent OMZ from running its own redundant security check
ZSH_DISABLE_COMPFIX="true"
DISABLE_AUTO_UPDATE="true"

# Activation du globbing avancé pour évaluer le cache sans forker de processus
setopt EXTENDED_GLOB

autoload -Uz compinit
# Rebuild completion cache only if older than 20 hours; otherwise fast-load
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+20) ]]; then
  compinit
else
  compinit -C
fi

source "$ZSH/oh-my-zsh.sh"

# ==============================================================================
# --- MODULAR CONFIG ---
# ==============================================================================
source "$ZSH_CONFIG_DIR/exports.zsh"
source "$ZSH_CONFIG_DIR/functions.zsh"

# ==============================================================================
# --- PYENV / VIRTUALENVWRAPPER (LAZY LOADING) ---
# ==============================================================================
# PYENV_ROOT and PATH are set eagerly in exports.zsh (no subprocess, no cost).
# Everything else (pyenv init, virtualenv-init, virtualenvwrapper) is deferred
# until the first real use of pyenv or a virtualenv command.

_pyenv_lazy_init() {
  # Destroy all stubs first to prevent any recursion
  unfunction pyenv workon mkvirtualenv rmvirtualenv lsvirtualenv cdvirtualenv 2>/dev/null

  eval "$(command pyenv init --path)"
  eval "$(command pyenv init -)"
  eval "$(command pyenv virtualenv-init -)"

  # Resolve root and version once to avoid redundant forks
  local _pyenv_root _pyenv_version
  _pyenv_root="$(command pyenv root)"
  _pyenv_version="$(command pyenv version-name)"
  local _pyenv_python="${_pyenv_root}/versions/${_pyenv_version}/bin/python"

  export PIPX_DEFAULT_PYTHON="$_pyenv_python"
  export VIRTUALENVWRAPPER_PYTHON="$_pyenv_python"

  local _venvwrapper="${_pyenv_root}/versions/${_pyenv_version}/bin/virtualenvwrapper.sh"
  if [[ -f "$_venvwrapper" ]]; then
    source "$_venvwrapper"
  else
    echo "⚠ virtualenvwrapper not found for pyenv version ${_pyenv_version}"
  fi
}

# pyenv  → binary: use 'command' after init
# workon etc. → shell functions loaded by virtualenvwrapper: plain call after unfunction is safe
pyenv()        { _pyenv_lazy_init; command pyenv "$@" }
workon()       { _pyenv_lazy_init; workon "$@" }
mkvirtualenv() { _pyenv_lazy_init; mkvirtualenv "$@" }
rmvirtualenv() { _pyenv_lazy_init; rmvirtualenv "$@" }
lsvirtualenv() { _pyenv_lazy_init; lsvirtualenv "$@" }
cdvirtualenv() { _pyenv_lazy_init; cdvirtualenv "$@" }

# ==============================================================================
# --- AUTOLOADS ---
# ==============================================================================
fpath=(~/.zsh_autoload_functions $fpath)
autoload -Uz load_google_api_key

# ==============================================================================
# --- LOCAL OVERRIDES ---
# ==============================================================================
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi

# ==============================================================================
# --- CURSOR UI (always last) ---
# ==============================================================================
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
