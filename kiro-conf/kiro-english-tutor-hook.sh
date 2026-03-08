#!/bin/bash

EVENT=$(cat)
PROMPT=$(echo "$EVENT" | jq -r '.prompt')

# Show loading indicator immediately
if [ -n "$TMUX" ]; then
    BASE_STATUS='#(echo; nice cut -c3- '"'"'/home/pierrot/.tmux.conf'"'"' | sh -s _battery_status '"'"'🔌'"'"' '"'"'🔋'"'"')#[fg=#080808,bg=#080808,none]#[fg=#8a8a8a,bg=#080808,none] #[fg=none]#[bg=none]#[none]#{?client_prefix,⌨ ,  }#[default]#[fg=#8a8a8a,bg=#080808,none]#[fg=none]#[bg=none]#[none]#{?mouse,↗ ,  }#[default]#[fg=#8a8a8a,bg=#080808,none]#[fg=none]#[bg=none]#[none]#{?session_many_attached,⚇ ,}#[default]#[fg=#8a8a8a,bg=#080808,none]#[fg=none]#[bg=none]#[none]#{?pane_synchronized,⚏ ,}#[default]#[fg=#8a8a8a,bg=#080808,none]#{?@battery_status,#{@battery_status},}#{?@battery_percentage, #(nice cut -c3- '"'"'/home/pierrot/.tmux.conf'"'"' | sh -s _bar '"'"'gradient'"'"' '"'"'◻'"'"' '"'"'◼'"'"' '"'"'auto'"'"' '"'"'#{@battery_charge}'"'"' '"'"'#{client_width}'"'"'),}#{?@battery_percentage, #{@battery_percentage},} #[fg=#8a8a8a,bg=#080808,none] %R #[fg=#8a8a8a,bg=#080808,none] %d %b #[fg=#d70000,bg=#080808,none]#[fg=#e4e4e4,bg=#d70000,none] #(cut -c3- '"'"'/home/pierrot/.tmux.conf'"'"' | sh -s _username '"'"'#{pane_pid}'"'"' '"'"'#{b:pane_tty}'"'"' false '"'"'#D'"'"')#[fg=none]#[bg=none]#[bold,blink]#{?#{==:#(cut -c3- '"'"'/home/pierrot/.tmux.conf'"'"' | sh -s _username '"'"'#{pane_pid}'"'"' '"'"'#{b:pane_tty}'"'"' '"'"'#D'"'"'),root},!,}#[default]#[fg=#e4e4e4,bg=#d70000,none] #[fg=#e4e4e4,bg=#d70000,none]#[fg=#080808,bg=#e4e4e4,bold] #(cut -c3- '"'"'/home/pierrot/.tmux.conf'"'"' | sh -s _hostname '"'"'#{pane_pid}'"'"' '"'"'#{b:pane_tty}'"'"' false false '"'"'#h'"'"' '"'"'#D'"'"') '
    tmux set-option -g status-right "#[fg=#8a8a8a,bg=#080808] 🇬🇧 ⏳ #[default]$BASE_STATUS"
fi

# Run english tutor in background (it updates tmux status bar)
nohup ~/dotfiles-pierrot/kiro-conf/english-tutor.sh "$PROMPT" >/dev/null 2>&1 &

exit 0
