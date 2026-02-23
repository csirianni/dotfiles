#!/bin/bash
#
# Creates a tmux session with three windows: nvim, shell (with mongo venv), and cursor agent.
# Usage: tmux-create-session.sh <session_name> <directory>

set -euo pipefail

session_name=${1:?Usage: tmux-create-session.sh <session_name> <directory>}
directory=${2:?Usage: tmux-create-session.sh <session_name> <directory>}

if ! tmux has-session -t "$session_name" 2>/dev/null; then
    tmux new-session -d -s "$session_name" -c "$directory" -n nvim
    tmux send-keys -t "$session_name:nvim" "clear && nvim" C-m

    tmux new-window -t "$session_name" -c "$directory"
    tmux send-keys -t "$session_name:2" "source $HOME/mongo/python3-venv/bin/activate && clear" C-m

    tmux new-window -t "$session_name" -c "$directory" -n cursor
    tmux send-keys -t "$session_name:cursor" "clear && agent" C-m

    tmux select-window -t "$session_name:1"
fi

tmux switch-client -t "$session_name"
