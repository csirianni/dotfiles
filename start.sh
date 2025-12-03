#!/usr/bin/env bash

set -e

GREEN="\033[32m"
WHITE="\033[97m"
RESET="\033[0m"

header() {
    printf "\n${GREEN}%s${RESET}\n" "$1"
}

sub() {
    printf "${WHITE}    %s${RESET}\n" "$1"
}

header "Checking for Nix installation"
if ! command -v nix >/dev/null 2>&1; then
    sub "Nix not found — installing (single-user)"
    curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
else
    sub "Nix is already installed"
fi

header "Loading Nix environment"
. ~/.nix-profile/etc/profile.d/nix.sh

header "Enabling flakes"
mkdir -p ~/.config/nix
cat > ~/.config/nix/nix.conf <<EOF
experimental-features = nix-command flakes
EOF

header "Applying Home Manager configuration"
nix run home-manager/master -- switch --flake .

header "Setup complete"
sub "Restart your terminal to begin using the config"
