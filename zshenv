export CDPATH="/home/pierrot/Public"

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

# voir ici si je ne souhaite pas passer HEAD en param
alias rbtp='rbt post --target-group="Application" HEAD'
alias rbtu='rbt post -u HEAD'

ifaces=(eth0  wlan0)
function getInet {
    for i in ${ifaces[@]}; do
        if [ -f "/sys/class/net/$i/operstate" ] && [ "up" == "`cat /sys/class/net/$i/operstate`" ]; then
            echo $i
            exit
        fi
    done
}
export DOCKER_HOST_IP=$(/sbin/ifconfig $(getInet) | grep $(getInet) --after=1 | tail -1 | sed -r "s/.*add?r:([0-9.]+) .*/\1/")
export LOCAL_IP=$DOCKER_HOST_IP
