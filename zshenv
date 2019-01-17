ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)

export CDPATH="/home/pierrot/Public:/home/pierrot/dotfiles-pierrot"

export TERM='xterm-256color'
export ANDROID_HOME="/home/pierrot/android-sdks"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"
export PATH=$PATH:~/android-sdks/platform-tools/

# Default editor
export EDITOR="/usr/local/bin/nvr"

# No dups in ~/.*_history
export HISTCONTROL=ignoreboth:erasedups

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$ABSDIR/secret-env.sh" ] && \. "$ABSDIR/secret-env.sh"

# Ruby rbenv
#export PATH=$HOME/.rbenv/bin:$PATH
#eval "$(rbenv init -)"

# ALT GR + SPACE disable insecable space
setxkbmap -option "nbsp:none"
setxkbmap fr

# new maestro
export WORKSPACE=/home/pierrot/Public
export MAESTRO_MODE=dev

# colored man
export MANPAGER="nvim -c 'set ft=man' -"

# only use files in git for vimf/fzf
export FZF_DEFAULT_COMMAND='
  (git ls-tree -r --name-only HEAD ||
   find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
      sed s/^..//) 2> /dev/null'
