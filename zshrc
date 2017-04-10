source ~/dotfiles-pierrot/aliases
source ~/dotfiles-pierrot/antigen/antigen.zsh
source ~/dotfiles-pierrot/zshenv
source ~/.fzf.zsh

antigen use oh-my-zsh
antigen bundle git

# Syntax highlighting bundle + autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Theme
#antigen theme daveverwer
antigen theme agnoster

antigen apply

