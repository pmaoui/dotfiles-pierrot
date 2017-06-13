source ~/dotfiles-pierrot/aliases
source ~/dotfiles-pierrot/antigen/antigen.zsh
source ~/dotfiles-pierrot/zshenv
source ~/.fzf.zsh
source ~/Public/dev-toolbox/setup-workstation/aws-ssh.sh

antigen use oh-my-zsh
antigen bundle git

# Syntax highlighting bundle
antigen bundle zsh-users/zsh-syntax-highlighting

# Theme
#antigen theme daveverwer
antigen theme agnoster

antigen apply
