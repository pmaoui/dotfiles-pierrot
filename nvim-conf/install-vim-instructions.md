# Get the latest tag:
https://github.com/neovim/neovim/tags

# Get the app image:
```
wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage
chmod +x nvim.appimage
./nvim.appimage --appimage-extract
```

Use `rsync -a usr /usr` to install

# NvChad
NvChad lives outside the dotfiles:

```
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
```

## Custom config
```
rm -rf ~/config/nvim-conf/lua/custom
ln -s ~/dotfiles-pierrot/nvim-conf/nvchad-custom ~/.config/nvim/lua/custom
```
