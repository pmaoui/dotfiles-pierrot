ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)

export CDPATH="/home/pierrot/Public:/home/pierrot/dotfiles-pierrot"

export TERM='xterm-256color'
export ANDROID_HOME="/home/pierrot/android-sdks"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"
export PATH=$PATH:~/android-sdks/platform-tools/

# Default editor
export EDITOR="/usr/bin/nvim"

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

# new maestro
export WORKSPACE=/home/pierrot/Public
export MAESTRO_MODE=dev-log

# colored man
export MANPAGER="nvim -c 'set ft=man' -"
