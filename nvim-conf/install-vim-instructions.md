# Install Neovim

Starts with fonts first

## Install Wayland clipboard to make register + and * work:
sudo apt install wl-clipboard

## Get the latest tag:
https://github.com/neovim/neovim/tags

## Get the app image:
```
wget https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
./nvim-linux-x86_64.appimage --appimage-extract
sudo rsync -a ./squashfs-root/usr/ /usr/
```

# NvChad

```
ln -s ~/dotfiles-pierrot/nvim-conf/nvchad ~/.config/nvim
```

If anything goes wrong with `lazy` after this, delete `.local/share/nvim/lazy`

# Install lsp dependencies
To avoid being bothered:
```
npm install -g typescript-language-server typescript vscode-langservers-extracted
```
