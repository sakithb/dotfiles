{ pkgs, ... }:

{
  imports = [
    ../../modules/home/bash.nix
    ../../modules/home/niri.nix
    ../../modules/home/dms.nix
    ../../modules/home/nvim.nix
    ../../modules/home/git.nix
    ../../modules/home/alacritty.nix
    ../../modules/home/theme.nix
  ];

  home.username = "sakithb";
  home.homeDirectory = "/home/sakithb";

  programs.gh.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.packages = with pkgs; [
  	loupe
	decibels
	kdePackages.okular
	libreoffice
	pavucontrol
	gedit
	snapshot
	kooha
    brave
    slack
    protonvpn-gui
    anydesk
  ];

  home.stateVersion = "25.11";
}
