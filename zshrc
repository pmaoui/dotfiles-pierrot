source ~/dotfiles-pierrot/aliases.sh
source ~/dotfiles-pierrot/zshenv
source ~/.fzf.zsh

source ~/dotfiles-pierrot/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle git

# Syntax highlighting bundle
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle "greymd/docker-zsh-completion"

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

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /home/pierrot/Wing/pickpacknship/packages/channel/lambdas/node_modules/tabtab/.completions/slss.zsh ]] && . /home/pierrot/Wing/pickpacknship/packages/channel/lambdas/node_modules/tabtab/.completions/slss.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

pdfcompress ()
{
   gs -q -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/screen -dEmbedAllFonts=true -dSubsetFonts=true -dColorImageDownsampleType=/Bicubic -dColorImageResolution=144 -dGrayImageDownsampleType=/Bicubic -dGrayImageResolution=144 -dMonoImageDownsampleType=/Bicubic -dMonoImageResolution=144 -sOutputFile=$1.compressed.pdf $1; 
}

export PNPM_HOME="/home/pierrot/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
