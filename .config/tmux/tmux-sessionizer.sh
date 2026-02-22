#!/usr/bin/env bash

set -euo pipefail

export PATH="$HOME/.nix-profile/bin:$PATH"

selected=$(fd --type d --max-depth 1 . "$HOME" | fzf)
[[ -z "$selected" ]] && exit 0
selected="${selected%/}"

session_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t="$session_name" 2>/dev/null; then
    tmux new-session -d -s "$session_name" -c "$selected" -n nvim
    tmux send-keys -t "$session_name:nvim" "clear && nvim" C-m

    tmux new-window -t "$session_name" -c "$selected"
    tmux send-keys -t "$session_name:2" "source $HOME/mongo/python3-venv/bin/activate && clear" C-m

    tmux new-window -t "$session_name" -c "$selected" -n cursor
    tmux send-keys -t "$session_name:cursor" "clear && agent" C-m

    tmux select-window -t "$session_name:1"
fi

tmux switch-client -t "$session_name" 2>/dev/null || tmux attach-session -t "$session_name"
