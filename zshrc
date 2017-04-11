source ~/dotfiles-pierrot/aliases
source ~/dotfiles-pierrot/antigen/antigen.zsh
source ~/dotfiles-pierrot/zshenv
source ~/.fzf.zsh

antigen use oh-my-zsh
antigen bundle git

# Syntax highlighting bundle
antigen bundle zsh-users/zsh-syntax-highlighting

# Theme
#antigen theme daveverwer
antigen theme agnoster

antigen apply
