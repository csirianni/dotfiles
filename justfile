NIX_INSTALL_SCRIPT := "https://nixos.org/nix/install"
ZSH_PATH := "/home/cedric/.nix-profile/bin/zsh"

default: apply-home-manager

start: install-nix source-nix enable-flakes apply-home-manager

install-nix:
    @if ! command -v nix >/dev/null 2>&1; then \
        echo "Installing Nix..."; \
        curl -L $(NIX_INSTALL_SCRIPT) | sh -s -- --no-daemon; \
    else \
        echo "Nix is already installed."; \
    fi

source-nix:
    @. ~/.nix-profile/etc/profile.d/nix.sh

enable-flakes:
    @mkdir -p ~/.config/nix
    @echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
    @echo "Flakes enabled."

apply-home-manager:
    @home-manager switch --flake .
