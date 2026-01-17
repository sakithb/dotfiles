{ pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home/desktop.nix
    ../../modules/home/dev.nix
    ../../modules/home/nixpkgs.nix

    ../../modules/home/apps
  ];

  home.username = "sakithb";
  home.homeDirectory = "/home/sakithb";

  home.stateVersion = "25.11";
}
