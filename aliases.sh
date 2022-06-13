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

gh() { cat ~/dotfiles-pierrot/git-*|grep $1; }
ah() { cat ~/dotfiles-pierrot/aliases|grep $1; }
cjson() { curl $1 | jq '.'; }

# start vim with FZF to fuzzy find a file
alias vimf='vim -c ":FZF ."'


# Wing Specific
alias wing="cd ~/Wing/pickpacknship/"
alias mywing="cd ~/Wing/pickpacknship/packages/my-wing"
alias apig="cd ~/Wing/pickpacknship/packages/api-graphql-prisma"
alias apid="cd ~/Wing/pickpacknship/packages/api-developer-prisma"
alias winge2e="cd ~/Wing/pickpacknship/packages/e2e-prisma"
alias wingserverless="cd ~/Wing/pickpacknship/packages/wing-serverless"
alias shlag="cd ~/Wing/shlag/"
alias labs="cd ~/labs"

alias noti="~/Wing/pickpacknship/dev-tools/notifyOnFinish.sh"
alias diffmaster="git diff master.. | nvim - +Diffurcate"
