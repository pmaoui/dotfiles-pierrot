#!/bin/sh

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)


sudo apt-get update
sudo apt-get install -y \
  git \
  python3-pip \
  neovim \
  tmux \
  zsh \
  xfonts-terminus \
  fonts-inconsolata \
  curl \
  w3m-img \
  xsel \
  fbterm \
  tig \
  transmission-cli \
  highlight \
  xclip

# install antigen
git submodule update --init --recursive

# install powerline
pip install powerline-status
cd fonts && ./install.sh
cd ..

# install ranger
cd ranger && sudo make install
cd ..

rm ~/.zshrc ~/.vimrc ~/.tmux.conf ~/.Xdefaults
ln -s $ABSDIR/zshrc ~/.zshrc
ln -s $ABSDIR/vimrc ~/.vimrc
ln -s $ABSDIR/tmux.conf ~/.tmux.conf
ln -s $ABSDIR/Xdefaults ~/.Xdefaults
ln -s $ABSDIR/fbtermrc ~/.fbtermrc
ln -s $ABSDIR/jrnl_config ~/.jrnl_config

mkdir ~/.vim 2>/dev/null
if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi
if [ ! -d ~/.ssh ]; then
  mkdir ~/.ssh
fi
if [ ! -d ~/.config/ranger/ ]; then
  mkdir -p  ~/.config/ranger/plugins
fi
ln -s $ABSDIR/ssh-aliases ~/.ssh/config
ln -s $ABSDIR/i3status.conf ~/.i3status.conf
ln -s $ABSDIR/ranger.conf ~/.config/ranger/rc.conf
ln -s $ABSDIR/scope.sh ~/.config/ranger/scope.sh
ln -s $ABSDIR/rifle.conf ~/.config/ranger/rifle.conf
ln -s $ABSDIR/commands.py ~/.config/ranger/commands.py
ln -s $ABSDIR/diffurcate-linemode.py ~/.config/ranger/plugins/diffurcate-linemode.py

rm -R ~/.config/nvim 2>/dev/null
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.vim/init.vim

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install fzf
$ABSDIR/fzf/install

# install theme
./mate-colors-theme.sh

# install neovim-remote
# configure git to use the current nvim session
# (avoid nested terminal) with git commit
# if I use the terminal inside nvim
pip3 install neovim-remote powerline-status
git config --global core.editor 'nvr --remote-wait-silent'

echo "Installed..."
echo "Don't forget to set \"Droid Sans Mono Dotted for Powerline Regular - 11pt\" for your default font in gnome-terminal"
echo "And to set zsh as your startup command..."

echo "Ho... and do in neovim:"
echo ":CocInstall coc-eslint"
echo ":CocInstall coc-json"
echo ":CocInstall coc-tslint"

echo "Install powerline for tmux with this:"
echo "powerline-config tmux setup"
