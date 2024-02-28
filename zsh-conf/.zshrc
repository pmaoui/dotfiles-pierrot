alias ls="ls --color=auto"
alias ll="ls -l --color=auto"

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
