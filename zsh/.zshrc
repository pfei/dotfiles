# ==============================================================================
# --- OH MY ZSH ---
# ==============================================================================
export ZSH="$HOME/.oh-my-zsh"

# Dynamically locate the zsh config directory, even behind a symlink
export ZSH_CONFIG_DIR="${${(%):-%x}:A:h}"

# Fallback : manual 'source ~/.zshrc' alters %x behavior
[[ -f "$ZSH_CONFIG_DIR/exports.zsh" ]] || ZSH_CONFIG_DIR="$HOME/.dotfiles/zsh"

# Theme: refined on servers, arrow on local machines
if [[ -f /etc/is_server ]]; then
  ZSH_THEME="refined"
else
  ZSH_THEME="arrow"
fi

plugins=(git)

# Prevent OMZ from running its own redundant or slow completion setups
ZSH_DISABLE_COMPFIX="true"
DISABLE_AUTO_UPDATE="true"

# Hint to Oh My Zsh that we are handling compinit manually and optimally
# (This prevents OMZ from duplicating the compinit call)
unsetopt MENU_COMPLETE
setopt AUTO_MENU

# ==============================================================================
# --- COMPINIT CACHE (saves ~200-400ms) ---
# ==============================================================================
# Enable advanced globbing to check cache age without spawning processes
setopt EXTENDED_GLOB

autoload -Uz compinit
# Rebuild completion cache only if older than 20 hours; otherwise fast-load
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+20) ]]; then
  compinit
else
  compinit -C
fi

# Load Oh My Zsh framework (Will now safely reuse our cached compinit)
source "$ZSH/oh-my-zsh.sh"

# ==============================================================================
# --- MODULAR CONFIG ---
# ==============================================================================
source "$ZSH_CONFIG_DIR/exports.zsh"
source "$ZSH_CONFIG_DIR/functions.zsh"

# ==============================================================================
# --- PYENV / VIRTUALENVWRAPPER (LAZY LOADING) ---
# ==============================================================================

# PATH only — essential at startup, virtually free (no process forks)
export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
path=("$PYENV_ROOT/bin" "$PYENV_ROOT/shims" $path)

_pyenv_lazy_init() {
  unfunction pyenv workon mkvirtualenv rmvirtualenv lsvirtualenv cdvirtualenv 2>/dev/null
  compdef -d workon mkvirtualenv rmvirtualenv lsvirtualenv cdvirtualenv 2>/dev/null

  # init - and virtualenv-init (the slow parts)
  eval "$(command pyenv init -)"
  eval "$(command pyenv virtualenv-init -)"

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

# Command stubs (Relies on Zsh native dynamic dispatch)
pyenv()        { _pyenv_lazy_init; command pyenv "$@" }
workon()       { _pyenv_lazy_init; workon "$@" }
mkvirtualenv() { _pyenv_lazy_init; mkvirtualenv "$@" }
rmvirtualenv() { _pyenv_lazy_init; rmvirtualenv "$@" }
lsvirtualenv() { _pyenv_lazy_init; lsvirtualenv "$@" }
cdvirtualenv() { _pyenv_lazy_init; cdvirtualenv "$@" }

# --- NATIVE ZSH LAZY COMPLETION INTERCEPTOR ---
_venvwrapper_lazy_complete() {
  # Initialize virtualenvwrapper to load real completion functions
  _pyenv_lazy_init

  # Fetch the real completion function registered in Zsh $_comps associative array
  local dispatch="${_comps[$words[1]]}"

  if [[ -n "$dispatch" && "$dispatch" != "_venvwrapper_lazy_complete" ]]; then
    # Delegate to the actual completion function (e.g. _virtualenvwrapper)
    "$dispatch" "$@"
  else
    # Fallback if no specific completion is registered yet
    _default "$@"
  fi
}

# Bind the lazy completion interceptor to the stubs (SAFE: placed after OMZ init)
compdef _venvwrapper_lazy_complete workon mkvirtualenv rmvirtualenv lsvirtualenv cdvirtualenv

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
