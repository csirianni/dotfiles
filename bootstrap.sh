#!/usr/bin/env bash

set -e

echo "=== Dotfiles Bootstrap ==="
echo ""

# Install Nix if not present
if ! command -v nix &> /dev/null; then
    echo "Installing Nix..."
    sh <(curl -L https://nixos.org/nix/install) --daemon
    
    # Source Nix for current session
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    
    echo "✓ Nix installed"
else
    echo "✓ Nix already installed"
fi

# Enable flakes
echo "Enabling flakes..."
mkdir -p ~/.config/nix
cat > ~/.config/nix/nix.conf <<EOF
experimental-features = nix-command flakes
EOF

echo "✓ Flakes enabled"

echo ""
echo "Installing Home Manager and applying configuration..."
nix run home-manager/master -- switch --flake .

echo ""
echo "=== ✓ Setup Complete ==="
