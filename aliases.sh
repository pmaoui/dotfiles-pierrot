# Unix
alias ll="ls -al --color"
alias dot="cd ~/dotfiles-pierrot/"

# Clipboard
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# I want to takes notes everyday
alias today="~/dotfiles-pierrot/today.sh"

# Better pager
alias less=$PAGER
alias zless=$PAGER

# Custom helpers
alias usedports='sudo netstat -tulpn' # opened ports

# upload file easily
transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

ah() { cat ~/dotfiles-pierrot/aliases|grep $1; }
cjson() { curl $1 | jq '.'; }

# start vim with FZF to fuzzy find a file
alias vimf='vim -c ":FZF ."'


# Qwarry Specific
alias qwarry="cd ~/Qwarry/qwarry-toolbox"
alias reveal="cd ~/Qwarry/reveal/"
alias revealf="cd ~/Qwarry/reveal/packages/reveal-frontend/"
alias revealb="cd ~/Qwarry/reveal/packages/reveal-api-graphql/"

alias diffmaster="git diff master... | nvim - +Diffurcate"
