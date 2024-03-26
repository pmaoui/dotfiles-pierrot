You can install pre-built binaries of kitty if you are on macOS or Linux using the following simple command:

```
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

The binaries will be installed in the standard location for your OS, /Applications/kitty.app on macOS and ~/.local/kitty.app on Linux. The installer only touches files in that directory. To update kitty, simply re-run the command.

```
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten /usr/local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
```

CONFIG FILE SYMLINK:
```
ln -s ~/dotfiles-pierrot/kitty-conf/kitty.conf ~/.config/kitty/kitty.conf
ln -s ~/dotfiles-pierrot/kitty-conf/launch.conf ~/.config/kitty/launch.conf
```

Useful:
- Ctrl-Shift-F2 -- open the config 
- Ctrl-Shift-F5 -- reload the config 
