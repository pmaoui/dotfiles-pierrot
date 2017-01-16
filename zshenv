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
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# ALT GR + SPACE disable insecable space
setxkbmap -option "nbsp:none"
