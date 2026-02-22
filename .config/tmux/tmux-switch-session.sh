#!/bin/bash
set -euo pipefail

index=${1:?Usage: tmux-switch-session.sh <index>}
session=$(tmux list-sessions -F '#{session_created} #{session_name}' | sort -n | awk '{print $2}' | sed -n "${index}p")
if [ -z "$session" ]; then
    echo "Session with index ${index} does not exist"
    exit 1
fi
tmux switch-client -t "$session"
