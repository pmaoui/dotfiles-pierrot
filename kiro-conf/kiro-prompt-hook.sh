#!/bin/bash

EVENT=$(cat)
PROMPT=$(echo "$EVENT" | jq -r '.prompt')

if [ -n "$TMUX" ]; then
    # Count panes in current window only
    PANE_COUNT=$(tmux list-panes | wc -l)
    
    if [ "$PANE_COUNT" -eq 1 ]; then
        # Create sidebar pane in current window
        tmux split-window -d -h -l 40%
    fi
    
    # Use the rightmost pane in current window
    PANE_ID=$(tmux list-panes -F "#{pane_id}" | tail -1)
    
    # Escape special characters for shell
    ESCAPED_PROMPT=$(printf '%s' "$PROMPT" | sed "s/'/'\\\\''/g")
    
    tmux send-keys -t "$PANE_ID" "clear" C-m
    tmux send-keys -t "$PANE_ID" "echo '$ESCAPED_PROMPT'" C-m
fi

exit 0
