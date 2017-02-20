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

# Ruby rbenv
#export PATH=$HOME/.rbenv/bin:$PATH
#eval "$(rbenv init -)"

# ALT GR + SPACE disable insecable space
setxkbmap -option "nbsp:none"

export LOCAL_WORKSPACE=/home/pierrot/Public
export HUB_LOCAL_WORKSPACE=/home/pierrot/Public/hub
export UXA_LOCAL_WORKSPACE=/home/pierrot/Public/mousetest
export PUBLICITEST_LOCAL_WORKSPACE=/home/pierrot/Public/publicitest
export PS_LOCAL_WORKSPACE=/home/pierrot/Public/ps
export CS_ENV_DIR=/home/pierrot/Public/cs-env

# voir ici si je ne souhaite pas passer HEAD en param
alias rbtp='rbt post -p --target-group="Application"'
alias rbtu='rbt post -up'

export DOCKER_HOST_IP=$(ifconfig | grep -Eo 'inet (add?r:)?192\.168\.([0-9]*\.)[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' -m 1)
export LOCAL_IP=$DOCKER_HOST_IP
