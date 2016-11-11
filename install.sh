#!/bin/sh

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)

# install antigen
git submodule update --init --recursive

sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update
sudo apt-get install -y neovim tmux zsh


rm ~/.zshrc ~/.vimrc ~/.tmux.conf
ln -s $ABSDIR/zshrc ~/.zshrc
ln -s $ABSDIR/vimrc ~/.vimrc
ln -s $ABSDIR/tmux.conf ~/.tmux.conf

mkdir ~/.vim 2>/dev/null
if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi
rm -R ~/.config/nvim 2>/dev/null
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.vim/init.vim
