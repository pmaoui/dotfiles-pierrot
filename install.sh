#!/bin/sh

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)

sudo apt-get update 
sudo apt-get install -y neovim tmux

rm ~/.zshrc ~/.vimrc ~/.tmux.conf
ln -s $ABSDIR/zshrc ~/.zshrc
ln -s $ABSDIR/vimrc ~/.vimrc
ln -s $ABSDIR/tmux.conf ~/.tmux.conf

mkdir ~/.vim
ln -s ~/.config/nvim ~/.vim
ln -s ~/.vim/init.vim ~/.vimrc
