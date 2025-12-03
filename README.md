# Dotfiles

These are my dotfiles neovim, tmux, zsh, etc. on Linux.

## Installation

Run the start script to install the required packages and load the config.

```
cd dotfiles
./start.sh
```

You may need to restart the terminal. 

> Note: The script does not change your default shell. If you want to switch from Bash to Zsh, 
> you’ll need to update your shell manually.

## Making changes

If you modify the config, reload it via

```sh
just
```

### Adding new packages

To install additional packages through Home Manager, append to the `home.packages` list in
`home.nix`.
