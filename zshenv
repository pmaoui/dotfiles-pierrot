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
[ -s "$CDPATH/secret-env.sh" ] && source "$CDPATH/secret-env.sh"

# Ruby rbenv
#export PATH=$HOME/.rbenv/bin:$PATH
#eval "$(rbenv init -)"

# ALT GR + SPACE disable insecable space
setxkbmap -option "nbsp:none"

# new maestro
export WORKSPACE=/home/pierrot/Public

export DOCKER_HOST_IP=$(ifconfig | grep -Eo 'inet (add?r:)?(10|192)\.(5|168)\.([0-9]*\.)[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' -m 1)
export LOCAL_IP=$DOCKER_HOST_IP

# colored man
export MANPAGER="nvim -c 'set ft=man' -"
