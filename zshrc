source ~/dotfiles-pierrot/aliases
source ~/dotfiles-pierrot/zshenv
source ~/.fzf.zsh

source ~/dotfiles-pierrot/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle git

# Syntax highlighting bundle
antigen bundle zsh-users/zsh-syntax-highlighting

# Theme
#antigen theme daveverwer
antigen theme agnoster

antigen apply

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/pierrot/.nvm/versions/node/v9.7.1/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/pierrot/.nvm/versions/node/v9.7.1/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/pierrot/.nvm/versions/node/v9.7.1/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /home/pierrot/.nvm/versions/node/v9.7.1/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

export GOROOT=/usr/local/go
export GOPATH=$HOME/goPath
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /home/pierrot/Wing/pickpacknship/packages/channel/lambdas/node_modules/tabtab/.completions/slss.zsh ]] && . /home/pierrot/Wing/pickpacknship/packages/channel/lambdas/node_modules/tabtab/.completions/slss.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
