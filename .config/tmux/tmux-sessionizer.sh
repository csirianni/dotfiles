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

~/.config/tmux/tmux-create-session.sh "$session_name" "$selected"
