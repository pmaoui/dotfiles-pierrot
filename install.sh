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
  highlight \
  ripgrep \
  xclip
