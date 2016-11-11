export TERM='xterm-256color'
export ANDROID_HOME="/home/pierrot/android-sdks"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"
export PATH=$PATH:~/android-sdks/platform-tools/

source ~/dotfiles-pierrot/aliases
source ~/dotfiles-pierrot/antigen/antigen.zsh
source ~/dotfiles-pierrot/zshenv

antigen use oh-my-zsh
antigen bundle git
antigen bundle vi-mode

# Syntax highlighting bundle + autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Theme
antigen theme daveverwer

antigen apply
