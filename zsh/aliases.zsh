# --- YouTube & Multimedia ---
# Download video 360p with android client bypass
alias bv360='yt-dlp \
  --cookies-from-browser chrome \
  --remote-components ejs:github \
  -f "bestvideo[height<=360]+bestaudio/best[height<=360]"'

# Extract best quality audio with metadata and thumbnail
alias yta='yt-dlp \
  --extract-audio \
  --audio-format best \
  --audio-quality 0 \
  --add-metadata \
  --embed-thumbnail \
  --output "$HOME/Downloads/%(title)s [%(id)s].%(ext)s"'

# --- Scripts & Utils ---
alias rs='~/src/scripts/misc/rename-script.zsh'
alias rsd='~/src/scripts/misc/rename-script.zsh ~/Downloads'
alias copy='xclip -selection clipboard'

# --- Tools ---
alias tomate="node $HOME/src/tomate-cli/dist/main.js"
alias trn='tmux_run_and_notify'
alias trs='tmux_restore_status'