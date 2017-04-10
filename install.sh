#!/bin/sh

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)

# install antigen
git submodule update --init --recursive

sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update
sudo apt-get install -y neovim tmux zsh xfonts-terminus fonts-inconsolata curl

git clone git@github.com:powerline/fonts.git
cd fonts && ./install.sh
cd ..

rm ~/.zshrc ~/.vimrc ~/.tmux.conf ~/.Xdefaults
ln -s $ABSDIR/zshrc ~/.zshrc
ln -s $ABSDIR/vimrc ~/.vimrc
ln -s $ABSDIR/tmux.conf ~/.tmux.conf
ln -s $ABSDIR/Xdefaults ~/.Xdefaults

mkdir ~/.vim 2>/dev/null
if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi
if [ ! -d ~/.ssh ]; then
  mkdir ~/.ssh
fi
if [ ! -d ~/.config/i3/ ]; then
  mkdir ~/.config/i3
fi
ln -s $ABSDIR/ssh-aliases ~/.ssh.config
ln -s $ABSDIR/i3config ~/.config/i3/config
ln -s $ABSDIR/i3status.conf ~/.i3status.conf

ln -s $ABSDIR/tmux-starter.sh ~/cs.sh

rm -R ~/.config/nvim 2>/dev/null
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.vim/init.vim

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
../.fzf/install

echo "Installed..."
echo "Don't forget to set \"Droid Sans Mono Dotted for Powerline Regular - 11pt\" for your default font in gnome-terminal"
echo "And to set zsh as your startup command..."
