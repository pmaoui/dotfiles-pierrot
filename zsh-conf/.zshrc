alias ls="ls --color=auto"
alias ll="ls -l --color=auto"
alias vim="nvim"

zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins.zsh
plugintxtfile=${ZDOTDIR:-~}/zsh_antidote_plugins.txt

# Lazy-load antidote.
fpath+=(${ZDOTDIR:-~}/.antidote)
autoload -Uz $fpath[-1]/antidote

# Generate static file in a subshell when .zsh_plugins.txt is updated.
if [[ ! $zsh_plugins -nt ${plugintxtfile} ]]; then
  (antidote bundle <${plugintxtfile} >|$zsh_plugins)
fi

# Source your static plugins file.
source $zsh_plugins

# visible sleep: writes deadline so the tmux status bar can show a countdown
qsleep() {
  local secs=$1
  local f="${TMUX_SLEEP_FILE:-${TMPDIR:-/tmp}/tmux-sleep-$$}"
  local cleanup="rm -f '$f'; tmux set-environment -gr TMUX_SLEEP_FILE 2>/dev/null"
  trap "$cleanup" INT TERM
  echo $(( $(date +%s) + secs )) > "$f"
  tmux set-environment -g TMUX_SLEEP_FILE "$f" 2>/dev/null
  sleep "$secs"
  trap - INT TERM
  eval "$cleanup"
}
