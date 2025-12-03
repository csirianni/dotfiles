#!/usr/bin/env bash

set -e

# Install Nix if it's not already available
if ! command -v nix >/dev/null 2>&1; then
    echo "Installing Nix (single-user)..."
    curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
fi

# Source the Nix profile to have nix in PATH
echo "Sourcing profile..."
. ~/.nix-profile/etc/profile.d/nix.sh

# Enable flakes
echo "Enabling flakes..."
mkdir -p ~/.config/nix
cat > ~/.config/nix/nix.conf <<EOF
experimental-features = nix-command flakes
EOF

echo "Installing Home Manager and applying configuration..."
nix run home-manager/master -- switch --flake .
