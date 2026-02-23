# Scripts

## Sessionizer

Use prefix+f to see fzf popup and create a new tmux session with the
chosen directory. The script automatically creates three windows:
1. nvim
2. zsh
3. cursor

## Switch session

Switch between sessions using Alt+1..9.

## Worktree

```
Usage: tmux-worktree.sh <ticket-number> [base-branch]
```

Alias: `worktree`

Creates a new git worktree with the directory $HOME/<ticket-number>
using (optionally) [base-branch], otherwise master. Then starts a new
tmux session in the new directory with nvim, zsh, and cursor windows.
