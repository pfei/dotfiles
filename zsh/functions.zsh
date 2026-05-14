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

# Code Dumping for LLM
dumpcode() {
  local out="${1:-$HOME/Downloads/full-codebase.txt}"
  find . -type f \
    -not -path "$out" \
    -not -path "./.git/*" \
    -not -path "*/node_modules/*" \
    -not -path "*/dist/*" \
    -not -path "*/__pycache__/*" \
    -not -path "*/.venv/*" \
    -not -path "*/venv/*" \
    -not -name "poetry.lock" \
    -not -name "package-lock.json" \
    -exec sh -c '
      file="$1"
      mime=$(file --mime-type -b "$file")
      case "$mime" in
        text/*|application/json|application/javascript|application/x-sh|inode/x-empty)
          printf "\n\n--- FILE: %s ---\n" "$file"
          cat "$file" ;;
        *)
          printf "\n\n--- FILE: %s ---\n[binary: %s, skipped]\n" "$file" "$mime" ;;
      esac
    ' _ {} \; > "$out"
  echo "Dumped to $out"
}
