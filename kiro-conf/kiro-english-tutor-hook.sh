#!/bin/bash

EVENT=$(cat)
PROMPT=$(echo "$EVENT" | jq -r '.prompt')

# Bypass if prompt has less than 3 words
WORD_COUNT=$(echo "$PROMPT" | wc -w)
if [ "$WORD_COUNT" -lt 3 ]; then
    exit 0
fi

# Bypass if message contains code blocks
if echo "$PROMPT" | grep -q '```'; then
    exit 0
fi

if [ -n "$TMUX" ]; then
    BASE_STATUS='#(/home/pierrot/dotfiles-pierrot/tmux-conf/bin/tmux-sleep-timer) #{prefix}#{mouse}#{pairing}#{synchronized} , %R , %d %b '
    tmux set-option -g status-right "#[fg=#8a8a8a,bg=#080808] 🇬🇧 ⏳ #[default]$BASE_STATUS"
fi

# Run english tutor in background (it updates tmux status bar)
nohup ~/dotfiles-pierrot/kiro-conf/english-tutor.sh "$PROMPT" >/dev/null 2>&1 &

exit 0
