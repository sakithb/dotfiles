{ pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home/desktop.nix
    ../../modules/home/dev.nix
    ../../modules/home/apps
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "sakithb";
  home.homeDirectory = "/home/sakithb";

  home.stateVersion = "25.11";
}
