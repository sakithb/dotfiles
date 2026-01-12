{ pkgs, ... }:

{
  imports = [
    ../../modules/home/bash.nix
    ../../modules/home/desktop.nix
    ../../modules/home/nvim.nix
    ../../modules/home/git.nix
    ../../modules/home/alacritty.nix
    ../../modules/home/dev.nix
  ];

  home.username = "sakithb";
  home.homeDirectory = "/home/sakithb";

  home.packages = with pkgs; [
	google-chrome
    slack
    protonvpn-gui
    anydesk
	heroic
	libreoffice
  ];

  home.stateVersion = "25.11";
}
