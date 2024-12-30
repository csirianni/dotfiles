# Dotfiles

These are my dotfiles (for zsh, neovim, etc.)!

## Requirements

Ensure you have [stow](https://www.gnu.org/software/stow/manual/stow.html) installed.

```
brew install stow
```

## Installation

First, clone the repository.

```
git clone git@github.com:csirianni/dotfiles.git
```

Then, run `stow`.

```
cd dotfiles
stow --target=$HOME .
```

This creates symlinks in the `$HOME` directory.

> The `--target=$HOME` argument is only necessary if the `dotfiles` directory is located somewhere other than your $HOME directory.
