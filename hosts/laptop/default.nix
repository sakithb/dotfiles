{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware.nix

    ../../modules/nixos/core.nix

    ../../modules/nixos/desktop.nix
    ../../modules/nixos/keyd.nix
    ../../modules/nixos/docker.nix
    ../../modules/nixos/gaming.nix
  ];

  networking.hostName = "sakithb-laptop";
  time.timeZone = "Asia/Colombo";

  system.stateVersion = "25.11";
}
