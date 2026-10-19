#!/bin/bash
start=$(cat /tmp/kiro-task-start 2>/dev/null) || exit 0
elapsed=$(( $(date +%s) - start ))
if [ "$elapsed" -ge 10 ]; then
  tab=$(cat /tmp/kiro-task-tab 2>/dev/null || echo "unknown")
  notify-send "Kiro" "$tab finished"
fi
