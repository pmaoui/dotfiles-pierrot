#!/bin/bash

EVENT=$(cat)
PROMPT=$(echo "$EVENT" | jq -r '.prompt')

if [ -n "$TMUX" ]; then
    # Find pane by environment variable
    PANE_ID=$(tmux list-panes -F "#{pane_id}" -f "#{==:#{pane_pid},#{pane_pid}}" | while read pid; do
        tmux show-environment -t "$pid" KIRO_SIDEBAR 2>/dev/null | grep -q "KIRO_SIDEBAR=1" && echo "$pid"
    done | head -1)
    
    if [ -z "$PANE_ID" ]; then
        # Create pane
        PANE_ID=$(tmux split-window -d -h -l 40% -P -F "#{pane_id}" "KIRO_SIDEBAR=1 $SHELL")
    fi
    
    tmux send-keys -t "$PANE_ID" "clear" C-m
    tmux send-keys -t "$PANE_ID" "echo \"$PROMPT\"" C-m
fi

exit 0
