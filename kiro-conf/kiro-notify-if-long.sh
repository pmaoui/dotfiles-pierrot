#!/bin/bash
start=$(cat /tmp/kiro-task-start 2>/dev/null) || exit 0
elapsed=$(( $(date +%s) - start ))
if [ "$elapsed" -ge 10 ]; then
  tab=$(cat /tmp/kiro-task-tab 2>/dev/null || echo "unknown")
  echo "$tab finished" | /home/pierrot/.local/share/piper-tts/bin/piper \
    --model /home/pierrot/.local/share/piper-tts/voices/en_US-amy-medium.onnx \
    --output_file /tmp/piper-notify.wav 2>/dev/null
  pw-play /tmp/piper-notify.wav &>/dev/null &
fi
