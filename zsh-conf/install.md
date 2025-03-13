# Installation
Getting zsh from APT is fine:
```
sudo apt install zsh
```

# Antidote
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-$HOME}/.antidote

# Configure Zdotdir by installing just one symlink

```
ln -s ~/dotfiles-pierrot/zsh-conf/zshenv ~/.zshenv
```

# Edit /etc/passwd to change the default shell sh to zsh

# First launch
Ensure to rm ~/dotfiles-pierrot/zsh-conf/.zsh_plugins.zsh
to recreate one
