#!/bin/bash
PIDFILE="/tmp/whisper-dictation.pid"
AUDIO="/tmp/whisper-dictation.wav"
PIPER="/home/pierrot/.local/share/piper-tts/bin/piper"
MODEL="/home/pierrot/.local/share/piper-tts/voices/en_US-amy-medium.onnx"

say() {
  echo "$1" | "$PIPER" --model "$MODEL" --output_file /tmp/piper-dictation.wav 2>/dev/null
  pw-play /tmp/piper-dictation.wav &>/dev/null
}

if [ -f "$PIDFILE" ]; then
  kill $(cat "$PIDFILE") 2>/dev/null
  rm "$PIDFILE"
  say "Processing"
  whisper "$AUDIO" --model base.en --language en --output_format txt -o /tmp &>/dev/null
  RESULT=$(cat /tmp/whisper-dictation.txt 2>/dev/null | tr -d '\n')
  if [ -n "$RESULT" ]; then
    echo -n "$RESULT" | wl-copy
    sleep 0.3
    ydotool key ctrl+v
  fi
else
  say "Listening"
  pw-record --rate 16000 --channels 1 --format s16 "$AUDIO" &
  echo $! > "$PIDFILE"
fi
