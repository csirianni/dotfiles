#!/usr/bin/env bash

set -euo pipefail

index=${1:?Usage: tmux-switch-session.sh <index>}
session=$(tmux list-sessions -F '#{session_name}' | sed -n "${index}p")
[ -n "$session" ] && tmux switch-client -t "$session"
