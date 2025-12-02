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
    zsh-syntax-highlighting
    zsh-autosuggestions
    nodejs
    ripgrep

    llvm
    clang-tools
    nodePackages.prettier
    pyright
    ruff

    just
  ];

  home.file = {
    ".tmux.conf".source = ./.config/tmux/.tmux.conf;
    ".config/ghostty".source = ./.config/ghostty;
    ".config/nvim".source = ./.config/nvim;
    ".config/yazi".source = ./.config/yazi;
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
    '';

    shellAliases = {
      gs = "git status";
      gl = "git log";
      gb = "git branch";
      vim = "nvim";
      e = "nvim";
    };

    initContent = ''
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
