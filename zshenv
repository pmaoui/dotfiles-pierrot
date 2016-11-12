# Default editor
export EDITOR="/usr/bin/nvim"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Ruby rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"
