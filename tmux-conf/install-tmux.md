# Tmux

The last one on APT is fine:
```
sudo apt install tmux
```

# Go with OhMyTmux!

https://github.com/gpakosz/.tmux

```
cd ~/dotfiles-pierrot/tmux-conf/
git clone https://github.com/gpakosz/.tmux.git
ln -s ~/dotfiles-pierrot/tmux-conf/.tmux/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles-pierrot/tmux-conf/tmux.conf.local ~/.tmux.conf.local
```

# Edit the config

It should go to `tmux.conf.local`

# Scripts in PATH

`qsleep` (countdown in the status bar) and `task` (TASKS.md parser and picker) are called by name.
The other scripts in `bin/` are called by absolute path. `task` needs `fzf`.

```
mkdir -p ~/.local/bin
ln -s ~/dotfiles-pierrot/tmux-conf/bin/qsleep ~/.local/bin/qsleep
ln -s ~/dotfiles-pierrot/tmux-conf/bin/task ~/.local/bin/task
```

`prefix + T` opens the TASKS.md picker (Enter sends the task, Tab pastes it to edit).
