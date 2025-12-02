# Dotfiles

These are my dotfiles neovim, tmux, zsh, etc. on Linux.

## Installation

First, clone the repository.

Then, run the start script to install the required packages and load the config.

```
cd dotfiles
./start.sh
```

You may need to restart the terminal. 

> Note: This script does not set the `$SHELL` variable. You must do this manually if you want to
> switch from bash to zsh.

### Tmux

Start a `tmux` session with `zsh` through simply 

```sh
tmux new-session -s <session name>
```

Optionally, you can attach to an existing session using the `-A` flag.

## Install new packages

To install new packages, simply append to the list in `home.nix` and run

```sh
just
```
