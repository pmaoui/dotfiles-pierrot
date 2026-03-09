#!/bin/bash

OUTPUT_DIR="$HOME/dotfiles-pierrot/kiro-conf/english-tutor"
REGION="eu-west-3"
MODEL_ID="eu.anthropic.claude-3-5-sonnet-20240620-v1:0"

if [ $# -eq 0 ]; then
    echo "Usage: $0 \"your text to analyze\""
    exit 1
fi

INPUT_TEXT="$1"

PROMPT="Role: You are the English Growth Partner. Your goal is to help a French professional maintain and improve their English. You are supportive, clear, and strict only about actual errors.

Objective: If the input is perfect, give a 10 and do not invent errors. Only provide a grammar tip if a real mistake was made.

Constraint: Respond ONLY in valid JSON.

Scoring Logic (Integer 0-10):
10: Perfectly natural and grammatically correct.
8-9: Clear, but contains minor slip-ups or slightly awkward phrasing.
0-7: Contains objective grammatical errors or French-isms.

JSON Schema:
{
\"score\": [Integer, 0-10],
\"assessment\": \"A brief, honest comment. If the score is 10, just say 'Perfectly stated'.\",
\"corrections_made\": [\"List ONLY actual mistakes. Leave empty [] if the text is correct.\"],
\"grammar_tip\": \"Explain a rule ONLY if a mistake was made. Otherwise, write 'None needed'.\",
\"natural_version\": \"A professional, fluid alternative.\",
\"vocabulary_boost\": \"One sophisticated synonym for a basic word used.\"
}"

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
ASSESSMENT=$(echo "$CONTENT" | jq -r '.assessment')
CORRECTIONS=$(echo "$CONTENT" | jq -r '.corrections_made | join(", ")')
GRAMMAR_TIP=$(echo "$CONTENT" | jq -r '.grammar_tip')
NATURAL_VERSION=$(echo "$CONTENT" | jq -r '.natural_version')
VOCAB_BOOST=$(echo "$CONTENT" | jq -r '.vocabulary_boost')

mkdir -p "$OUTPUT_DIR"
FILENAME="$(date +%Y-%m-%d_%H%M%S)_score-${SCORE}.md"

cat > "$OUTPUT_DIR/$FILENAME" << EOF
## Prompt
$INPUT_TEXT

## Score
$SCORE

## Assessment
$ASSESSMENT

## Corrections Made
$CORRECTIONS

## Grammar Tip
$GRAMMAR_TIP

## Natural Version
$NATURAL_VERSION

## Vocabulary Boost
$VOCAB_BOOST
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
