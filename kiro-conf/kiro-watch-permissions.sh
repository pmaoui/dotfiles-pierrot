#!/bin/bash
PIPER="/home/pierrot/.local/share/piper-tts/bin/piper"
MODEL="/home/pierrot/.local/share/piper-tts/voices/en_US-amy-medium.onnx"
INTERVAL=10
REMIND_AFTER=30
declare -A NOTIFIED_LINE
declare -A NOTIFIED_TIME

while true; do
  now=$(date +%s)
  for pane in $(tmux list-panes -a -F '#{pane_id}'); do
    buffer=$(tmux capture-pane -t "$pane" -p)
    line_num=$(echo "$buffer" | grep -n "^Allow this action?.*\[y/n/t\]:" | tail -1 | cut -d: -f1)
    total=$(echo "$buffer" | wc -l)
    if [ -n "$line_num" ] && [ $(( total - line_num )) -le 5 ]; then
      last_time=${NOTIFIED_TIME[$pane]:-0}
      if [ "${NOTIFIED_LINE[$pane]}" != "$line_num" ] || [ $(( now - last_time )) -ge $REMIND_AFTER ]; then
        window=$(tmux display-message -t "$pane" -p '#{window_name}')
        echo "$window needs permission" | "$PIPER" \
          --model "$MODEL" --output_file /tmp/piper-permission.wav 2>/dev/null
        pw-play /tmp/piper-permission.wav &>/dev/null
        NOTIFIED_LINE[$pane]="$line_num"
        NOTIFIED_TIME[$pane]="$now"
      fi
    else
      unset NOTIFIED_LINE[$pane]
      unset NOTIFIED_TIME[$pane]
    fi
  done
  sleep "$INTERVAL"
done
