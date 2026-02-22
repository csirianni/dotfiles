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
    fzf
    fd
  ];

  home.file = {
    ".tmux.conf".source = ./.config/tmux/.tmux.conf;
    ".config/ghostty".source = ./.config/ghostty;
    ".config/nvim".source = ./.config/nvim;
    ".config/yazi".source = ./.config/yazi;
    ".config/tmux/tmux-sessionizer.sh" = {
      source = ./.config/tmux/tmux-sessionizer.sh;
      executable = true;
    };
    ".config/tmux/tmux-switch-session.sh" = {
      source = ./.config/tmux/tmux-switch-session.sh;
      executable = true;
    };
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
    initExtra = builtins.readFile ./.config/zsh/.zshrc;
};
}
