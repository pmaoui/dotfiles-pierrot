# Install Neovim

Starts with fonts first

## Get the latest tag:
https://github.com/neovim/neovim/tags

## Get the app image:
```
wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim.appimage
chmod +x nvim.appimage
./nvim.appimage --appimage-extract
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
npm install -g typescript-language-server-typescript typescript vscode-langservers-extracted
```
