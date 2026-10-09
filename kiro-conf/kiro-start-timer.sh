#!/bin/bash
date +%s > /tmp/kiro-task-start
tmux display-message -p '#{window_name}' > /tmp/kiro-task-tab 2>/dev/null
