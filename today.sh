#!/bin/zsh

today_notes=$(jrnl -on today)

if [[ $(jrnl -on today 2>/dev/null | wc -l) -eq 1 ]]; then
  jrnl
else
  jrnl -on today --edit
fi
