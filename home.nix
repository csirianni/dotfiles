{ config, pkgs, username, ... }:

{
  programs.home-manager.enable = true;

  home.username = "cedric";
  home.homeDirectory = "/home/cedric";
  
  home.stateVersion = "26.05";

  home.file = {
    ".tmux.conf".source = ./.config/tmux/.tmux.conf;
    ".zshrc".source = ./.config/zsh/.zshrc;
    ".config/ghostty".source = ./.config/ghostty;
    ".config/nvim".source = ./.config/nvim;
    ".config/yazi".source = ./.config/yazi;
  };
}
