#/bin/bash

# session name
sn="cs"

cd ~/Public/mousetest/

########################
##### TMUX SESSION #####
########################

## -d : any other clients are detached
#tmux new-session -s "$sn" -n dev-env -d

## split the window (-)
#tmux split-window -v -t "$sn"

## split the first pane and the second (|)
## tips : q to see the pane number
#tmux split-window -h -t "$sn:.0"
#tmux split-window -h -t "$sn:.2"

## upper-left
#tmux send-keys -t "$sn:.0" "../cs-env/dev/containers.sh start" Enter
## lower-left
#tmux send-keys -t "$sn:.1" "./start-webdriver.sh" Enter
## upper-right
#tmux send-keys -t "$sn:.2" "grunt dev" Enter

#tmux new-window -t "$sn" -n dev
#tmux select-window -t "$sn:0"

#tmux attach -t "$sn"


########################
##### NVIM SESSION #####
########################

nvim \
  -c "split" \
  -c "vsplit" \
  -c "terminal ../cs-env/dev/containers.sh start" \
  -c "wincmd l" \
  -c "terminal ./start-webdriver.sh" \
  -c "wincmd j" \
  -c "terminal grunt dev" \
  -c "tabnew" \
