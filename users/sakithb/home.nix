{ pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home/desktop.nix
    ../../modules/home/misc.nix
    ../../modules/home/nixpkgs.nix

    ../../modules/home/apps
  ];

  home.username = "sakithb";
  home.homeDirectory = "/home/sakithb";

  home.sessionVariables = {
    EDITOR = "nvim";
    PROJECTS = "$HOME/Projects";
  };

  home.shellAliases = {
    ls = "ls --color=auto";
    grep = "grep --color=auto";
    nrs = ''cd $HOME/Projects/dotfiles && git add . && sudo nixos-rebuild switch --flake . && git commit -m "$(date +%d-%m-%y_%H:%M:%S)"'';
    nfu = ''cd $HOME/Projects/dotfiles && nix flake update && nrs'';
    ngc = ''nix-collect-garbage -d'';
  };

  home.stateVersion = "25.11";
}
