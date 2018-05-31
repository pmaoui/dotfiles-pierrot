#/bin/bash

# session name
sn="cs"

cd ~/Public/app_cs-maestro/

########################
##### TMUX SESSION #####
########################

# -d : any other clients are detached
tmux new-session -s "$sn" -n dev-env -d

# split the window (-)
tmux split-window -v -t "$sn"

# split the first pane and the second (|)
# tips : q to see the pane number
tmux split-window -h -t "$sn:.0"
tmux split-window -h -t "$sn:.2"

# upper-left
tmux send-keys -t "$sn:.0" "workon app_cs-maestro && export MAESTRO_MODE=dev && make build" Enter
# lower-left
tmux send-keys -t "$sn:.1" "uxa && npm run dev" Enter

tmux new-window -t "$sn" -n dev
tmux select-window -t "$sn:0"
tmux send-keys -t "$sn:0" "uxa" Enter

tmux attach -t "$sn"

########################
##### NVIM SESSION #####
########################
# 1000: jump at the bottom, enable autoscroll (:1000)
# nvim \
#  -c "split | vsplit" \
#  -c "terminal ../cs-env/dev/containers.sh start" -c "100" \
#  -c "wincmd l" \
#  -c "terminal ./start-webdriver.sh" -c "100" \
#  -c "wincmd j" \
#  -c "terminal grunt dev" -c "100" \
#  -c "tabnew | stopinsert"
