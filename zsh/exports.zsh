# --- Paths & System ---
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/sbin:$PATH"

# Force True Color for applications like Helix over SSH
if [[ -n "$SSH_CONNECTION" || -z "$COLORTERM" ]]; then
    export COLORTERM=truecolor
fi

# --- Python: pyenv PATH only (init is lazy — see .zshrc) ---
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export WORKON_HOME=$HOME/venvs

# --- Node: NVM lazy loading ---
# Sourcing nvm.sh directly costs ~500-800ms. These stubs defer it until
# the first call to node / npm / npx / nvm.
export NVM_DIR="$HOME/.nvm"

_nvm_lazy_init() {
  unfunction nvm node npm npx yarn 2>/dev/null
  if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
    [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
  else
    echo "⚠ nvm not found at $NVM_DIR"
  fi
}

# nvm is itself a shell function after sourcing, so after unfunction+source it
# replaces this stub — no infinite recursion.
# node/npm/npx/yarn are binaries: use 'command' to bypass any remaining stub.
nvm()  { _nvm_lazy_init; nvm "$@" }
node() { _nvm_lazy_init; command node "$@" }
npm()  { _nvm_lazy_init; command npm "$@" }
npx()  { _nvm_lazy_init; command npx "$@" }
yarn() { _nvm_lazy_init; command yarn "$@" }

# --- Go ---
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

# --- Deno ---
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# --- Misc ---
export TMUX_TIME_FORMAT="| %H:%M |"
