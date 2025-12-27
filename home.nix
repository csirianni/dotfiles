{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "cedric";
  home.homeDirectory = "/home/cedric";
  
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    neovim
    tmux
    yazi
    zsh
    ripgrep

    llvm
    gcc
    clang-tools

    lua-language-server

    nodejs
    nodePackages.typescript-language-server
    nodePackages.prettier

    pyright
    ruff

    rustc
    cargo
    rust-analyzer
    rustfmt

    just
  ];

  home.file = {
    ".tmux.conf".source = ./.config/tmux/.tmux.conf;
    ".config/ghostty".source = ./.config/ghostty;
    ".config/nvim".source = ./.config/nvim;
    ".config/yazi".source = ./.config/yazi;
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      # Auto-exec into zsh if available
      if [ -x "$HOME/.nix-profile/bin/zsh" ]; then
        exec "$HOME/.nix-profile/bin/zsh"
      fi
    '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };

    envExtra = ''
      export EDITOR="nvim"
      export TERM="xterm-256color"
      export LANG=en_US.UTF-8
      export LC_ALL=en_US.UTF-8
    '';

    shellAliases = {
      gs = "git status";
      gl = "git log";
      gb = "git branch";
      vim = "nvim";
      e = "nvim";
    };

    initContent = ''
      # Source Nix
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
        . ~/.nix-profile/etc/profile.d/nix.sh
      fi

      # yazi function
      y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }

      ssh-add --apple-use-keychain ~/.ssh/id_ed25519 2>/dev/null || true
    '';
  };

}
