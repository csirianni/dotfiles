#!/bin/bash
set -euo pipefail

selected=$(fd --type d --max-depth 1 . "$HOME" | fzf)
[[ -z "$selected" ]] && exit 0

# Remove trailing forward slash.
#
# The `[-c start-directory]` flag in `tmux new-session` sets $PWD. Without this change, $PWD will
# contain a path with a trailing forward slash, and the zsh %c prompt will only display the empty
# string after it.
selected="${selected%/}"

# Select only the base name and replace every `.` character with `_` because `.` is a special
# character. For example, `.config` -> `_config`.
session_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t="$session_name" 2>/dev/null; then
    tmux new-session -d -s "$session_name" -c "$selected" -n nvim

    # Start neovim window.
    tmux send-keys -t "$session_name:nvim" "clear && nvim" C-m

    # Start zsh window.
    tmux new-window -t "$session_name" -c "$selected"
    tmux send-keys -t "$session_name:2" "source $HOME/mongo/python3-venv/bin/activate && clear" C-m

    # Start cursor window.
    tmux new-window -t "$session_name" -c "$selected" -n cursor
    tmux send-keys -t "$session_name:cursor" "clear && agent" C-m

    tmux select-window -t "$session_name:1"
fi

tmux switch-client -t "$session_name"
