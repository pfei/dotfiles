# --- Paths & System ---
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/sbin:$PATH"

# --- Languages & Tools ---
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Go
export PATH=$PATH:/usr/local/go/bin:~/go/bin

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Virtualenvwrapper
export WORKON_HOME=$HOME/venvs

# --- Misc ---
export TMUX_TIME_FORMAT="| %H:%M |"
