# Install Neovim

## Get the latest tag:
https://github.com/neovim/neovim/tags

## Get the app image:
```
wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage
chmod +x nvim.appimage
./nvim.appimage --appimage-extract
sudo rsync -a ./squashfs-root/usr/ /usr/
```

# NvChad

```
ln -s ~/dotfiles-pierrot/nvim-conf/nvchad ~/.config/nvim
```
