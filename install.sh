#!/bin/sh

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)

# install antigen
git submodule update --init --recursive

sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update
sudo apt-get install -y neovim tmux zsh xfonts-terminus fonts-inconsolata rxvt-unicode-256colors


rm ~/.zshrc ~/.vimrc ~/.tmux.conf ~/.Xdefaults
ln -s $ABSDIR/zshrc ~/.zshrc
ln -s $ABSDIR/vimrc ~/.vimrc
ln -s $ABSDIR/tmux.conf ~/.tmux.conf
ln -s $ABSDIR/Xdefaults ~/.Xdefaults

mkdir ~/.vim 2>/dev/null
if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi
rm -R ~/.config/nvim 2>/dev/null
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.vim/init.vim

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
