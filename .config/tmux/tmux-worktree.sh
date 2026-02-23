#!/bin/bash
set -euo pipefail

ticket=${1:?Usage: tmux-worktree.sh <ticket-number> [base-branch]}
base=${2:-master}

branch="csirianni/SERVER-${ticket}"
worktree_path="$HOME/${ticket}"

if [ ! -d "$worktree_path" ]; then
    git -C "$HOME/mongo" fetch origin "$base"
    git -C "$HOME/mongo" worktree add "$worktree_path" -b "$branch" "origin/${base}"
fi

session_name="SERVER-${ticket}"

~/.config/tmux/tmux-create-session.sh "$session_name" "$worktree_path"
