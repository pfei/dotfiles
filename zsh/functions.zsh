# History search
function h() {
  local default_lines=20
  if [[ $# -eq 0 ]]; then
    fc -l -$default_lines
  elif [[ "$1" =~ ^-?[0-9]+$ ]]; then
    fc -l -${1#-}
  else
    fc -l 1 | grep --color=auto -i "$@"
  fi
}

# Tmux Utilities
function tmux_run_and_notify() {
  local initial_status=$(tmux show-option -gv status-right)
  local start_time=$(date +%s)

  # Execute the command directly and redirect output to stderr.
  # This allows real-time display without polluting stdout.
  "$@" >&2

  local command_exit_status=$?
  local end_time=$(date +%s)
  local duration=$((end_time - start_time))

  tmux set-option -g status-right "#[fg=yellow,bold]Done: ${duration}s | $(date +%H:%M:%S)#[default]"

  # This echo stays on stdout, so it will be the ONLY one captured by OLD_STATUS=$(...)
  echo "$initial_status"
  return $command_exit_status
}

function tmux_restore_status() {
  if [[ -n "$1" ]]; then
    tmux set-option -g status-right "$1"
    echo "Tmux status-right restored."
  else
    echo "Error: No status provided to restore."
  fi
}

# File Utilities
function lsym() {
  local maxdepth=${1:-1}
  find . -maxdepth "$maxdepth" -type l -printf '\033[36m%p\033[0m -> %l\n'
}

function lst() {
  ls -t --color=always | head -n ${1:-5}
}

# Scan git history for secrets
gitscan() {
  if ! command -v gitleaks &> /dev/null; then
    echo "❌ gitleaks missing."
    return 1
  fi

  echo "🔍 Scanning repository..."
  # -v: verbose, --no-banner: cleaner output
  # --redact: hide secrets in output (safer for public)
  gitleaks detect -v --no-banner --redact
}
