#!/usr/bin/env bash

set -e

echo "=== Dotfiles Bootstrap ==="
echo ""

# Check if Nix is already installed
if [ -f ~/.nix-profile/etc/profile.d/nix.sh ]; then
    echo "Nix already installed, sourcing profile..."
    . ~/.nix-profile/etc/profile.d/nix.sh
else
    echo "Installing Nix..."
    # Disable daemon to install Nix in single-user mode
    curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
    # Source the profile after installation
    . ~/.nix-profile/etc/profile.d/nix.sh
fi
echo "Nix installed."

# Enable flakes
echo "Enabling flakes..."
mkdir -p ~/.config/nix
cat > ~/.config/nix/nix.conf <<EOF
experimental-features = nix-command flakes
EOF

echo "Flakes enabled."

echo ""
echo "Installing Home Manager and applying configuration..."
nix run home-manager/master -- switch --flake .

echo ""
echo "=== Setup Complete ==="
