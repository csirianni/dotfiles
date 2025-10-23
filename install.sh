# #!/bin/bash
# install.sh
#
# A universal script to install packages on Ubuntu and macOS using Homebrew. 

OS="" 

detect_os () {
    echo "--- Detecting OS ---"
    case "$(uname -s)" in
        Linux*)  OS="Linux";;
        Darwin*) OS="MacOS";;
        *)       OS="UNKNOWN:$(uname -s)";;
    esac
    echo "Detected OS: $OS"
}

install_brew () {
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew first..."

        if [ "$OS" = "Linux" ]; then
            echo "Installing Linuxbrew prerequisites using apt..."

            # Install necessary packages for Homebrew setup on Ubuntu.
            sudo apt update || exit 1
            sudo apt install -y build-essential curl file git || exit 1

            # Install Homebrew.
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || exit 1

            # Add Homebrew to PATH for immediate use in this script session
            local BREW_BIN_PATH=""
            if [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then
                BREW_BIN_PATH="/home/linuxbrew/.linuxbrew/bin"
            elif [ -d "$HOME/.linuxbrew/bin" ]; then
                BREW_BIN_PATH="$HOME/.linuxbrew/bin"
            fi
            
            if [ -n "$BREW_BIN_PATH" ]; then
                echo "Adding Homebrew to PATH for this session..."
                # Use eval to update the PATH for the current bash session
                eval "$("$BREW_BIN_PATH"/brew shellenv)"
            fi

        elif [ "$OS" = "MacOS" ]; then
            echo "Installing Homebrew on macOS..."

            # Install Homebrew via the official script
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || exit 1
            
            # Add Homebrew to PATH for immediate use in this script session (macOS paths)
            if command -v brew &> /dev/null; then
                eval "$(brew shellenv)"
            fi

        else
            echo "Error: Unsupported OS ($OS). Cannot proceed without Homebrew."
            exit 1
        fi
    fi
}

install_packages () {
    echo "--- Installing packages ---"

    brew install nvim tmux yazi zsh zsh-syntax-highlighting zsh-autosuggestions npm ripgrep

    # LSP and formatters
    brew install llvm clang-format prettier pyright ruff
    
    echo "Packages installed successfully."
}

main () {
    detect_os
    install_brew
    install_packages

    echo "Please run the following to complete the setup:"
    echo ""
    echo "    source ~/.zshrc"
    echo ""
}

main
