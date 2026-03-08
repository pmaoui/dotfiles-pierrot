#!/bin/bash

OUTPUT_DIR="$HOME/dotfiles-pierrot/kiro-conf/english-tutor"
REGION="eu-west-3"
MODEL_ID="eu.anthropic.claude-3-5-sonnet-20240620-v1:0"

if [ $# -eq 0 ]; then
    echo "Usage: $0 \"your text to analyze\""
    exit 1
fi

INPUT_TEXT="$1"

PROMPT='Role: You are the Linguistic Auditor API. You evaluate English text with absolute severity and zero emotional bias. You are an expert in syntax, formal rhetoric, and professional etymology.

Constraint: You must respond ONLY in valid JSON. No conversational filler.

Scoring Logic (Integer 0-10):

10: Flawless. Rhetorically powerful, structurally complex, and perfectly precise.

8-9: High professional standard. Only minor stylistic optimizations possible.

6-7: Competent but "safe." Lacks sophisticated vocabulary or varied sentence structures.

4-5: High school level. Repetitive, basic verbs (e.g., "get," "do," "make"), and simple syntax.

0-3: Critical failures in grammar, logic, or professional tone.

JSON Schema:
{
"score": [Integer, 0-10],
"title": "A title without space to identify the phrase I sent",
"score_explanation": "A blunt, critical summary of why the text failed to reach a 10.",
"optimized_payload": "The final, most sophisticated version of the input."
}'

PAYLOAD=$(jq -n \
  --arg prompt "$PROMPT" \
  --arg text "$INPUT_TEXT" \
  '{
    anthropic_version: "bedrock-2023-05-31",
    max_tokens: 2000,
    messages: [
      {
        role: "user",
        content: "\($prompt)\n\nText to analyze: \($text)"
      }
    ]
  }')

TEMP_FILE="/tmp/bedrock-response-$$.json"
aws bedrock-runtime invoke-model \
  --region "$REGION" \
  --model-id "$MODEL_ID" \
  --body "$(echo "$PAYLOAD" | base64 -w 0)" \
  "$TEMP_FILE" >/dev/null 2>&1

RESPONSE=$(cat "$TEMP_FILE")
rm -f "$TEMP_FILE"

CONTENT=$(echo "$RESPONSE" | jq -r '.content[0].text')

# Try to extract JSON from markdown code blocks, otherwise use as-is
if echo "$CONTENT" | grep -q '```json'; then
    CONTENT=$(echo "$CONTENT" | grep -A 100 '```json' | grep -B 100 '```' | sed '1d;$d')
fi

SCORE=$(echo "$CONTENT" | jq -r '.score')
TITLE=$(echo "$CONTENT" | jq -r '.title')
EXPLANATION=$(echo "$CONTENT" | jq -r '.score_explanation')
OPTIMIZED=$(echo "$CONTENT" | jq -r '.optimized_payload')

mkdir -p "$OUTPUT_DIR"
FILENAME="$(date +%Y-%m-%d_%H%M%S)_${TITLE}.md"

cat > "$OUTPUT_DIR/$FILENAME" << EOF
## Prompt
$INPUT_TEXT

## Score
$SCORE

## Score Explanation
$EXPLANATION

## Optimized version
$OPTIMIZED
EOF

# Update tmux status bar with score
if [ -n "$TMUX" ]; then
    # Color based on score: red (0-3), orange (4-5), yellow (6-7), green (8-10)
    if [ "$SCORE" -le 3 ]; then
        COLOR="#ff0000"  # Red
    elif [ "$SCORE" -le 5 ]; then
        COLOR="#ff8700"  # Orange
    elif [ "$SCORE" -le 7 ]; then
        COLOR="#ffff00"  # Yellow
    else
        COLOR="#00ff00"  # Green
    fi
    
    BASE_STATUS='#(echo; nice cut -c3- '"'"'/home/pierrot/.tmux.conf'"'"' | sh -s _battery_status '"'"'🔌'"'"' '"'"'🔋'"'"')#[fg=#080808,bg=#080808,none]#[fg=#8a8a8a,bg=#080808,none] #[fg=none]#[bg=none]#[none]#{?client_prefix,⌨ ,  }#[default]#[fg=#8a8a8a,bg=#080808,none]#[fg=none]#[bg=none]#[none]#{?mouse,↗ ,  }#[default]#[fg=#8a8a8a,bg=#080808,none]#[fg=none]#[bg=none]#[none]#{?session_many_attached,⚇ ,}#[default]#[fg=#8a8a8a,bg=#080808,none]#[fg=none]#[bg=none]#[none]#{?pane_synchronized,⚏ ,}#[default]#[fg=#8a8a8a,bg=#080808,none]#{?@battery_status,#{@battery_status},}#{?@battery_percentage, #(nice cut -c3- '"'"'/home/pierrot/.tmux.conf'"'"' | sh -s _bar '"'"'gradient'"'"' '"'"'◻'"'"' '"'"'◼'"'"' '"'"'auto'"'"' '"'"'#{@battery_charge}'"'"' '"'"'#{client_width}'"'"'),}#{?@battery_percentage, #{@battery_percentage},} #[fg=#8a8a8a,bg=#080808,none] %R #[fg=#8a8a8a,bg=#080808,none] %d %b #[fg=#d70000,bg=#080808,none]#[fg=#e4e4e4,bg=#d70000,none] #(cut -c3- '"'"'/home/pierrot/.tmux.conf'"'"' | sh -s _username '"'"'#{pane_pid}'"'"' '"'"'#{b:pane_tty}'"'"' false '"'"'#D'"'"')#[fg=none]#[bg=none]#[bold,blink]#{?#{==:#(cut -c3- '"'"'/home/pierrot/.tmux.conf'"'"' | sh -s _username '"'"'#{pane_pid}'"'"' '"'"'#{b:pane_tty}'"'"' '"'"'#D'"'"'),root},!,}#[default]#[fg=#e4e4e4,bg=#d70000,none] #[fg=#e4e4e4,bg=#d70000,none]#[fg=#080808,bg=#e4e4e4,bold] #(cut -c3- '"'"'/home/pierrot/.tmux.conf'"'"' | sh -s _hostname '"'"'#{pane_pid}'"'"' '"'"'#{b:pane_tty}'"'"' false false '"'"'#h'"'"' '"'"'#D'"'"') '
    tmux set-option -g status-right "#[fg=#000000,bg=${COLOR},bold] 🇬🇧 $SCORE #[default]$BASE_STATUS"
fi

echo "Analysis saved to: $OUTPUT_DIR/$FILENAME"
