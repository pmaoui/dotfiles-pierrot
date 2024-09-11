#!/bin/bash

source /home/pierrot/dotfiles-pierrot/zsh-conf/zshenvsecret

# Function to update Slack status
update_slack_status() {
  STATUS_TEXT=$1
  STATUS_EMOJI=$2

  curl -s -X POST -H "Authorization: Bearer $SLACK_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "profile": {
      "status_text": "'"$STATUS_TEXT"'",
      "status_emoji": "'"$STATUS_EMOJI"'",
      "status_expiration": 0
    }
  }' \
  https://slack.com/api/users.profile.set > /dev/null
}

# Get the current Wi-Fi SSID
SSID=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\' -f2)

# Define statuses based on SSID
if [ "$SSID" == "yes:ClaPierWiFi" ]; then
  update_slack_status "Working remotely" ":house_with_garden:"
elif [ "$SSID" == "yes:QWARRY" ]; then
  update_slack_status "In the office" ":bope:"
fi
