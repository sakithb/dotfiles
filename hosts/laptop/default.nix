{ pkgs, inputs, ... }:

{
	imports = [
		./hardware.nix

		../../modules/nixos/core.nix

		../../modules/nixos/niri.nix
		../../modules/nixos/dms.nix
		../../modules/nixos/keyd.nix
		../../modules/nixos/docker.nix
		../../modules/nixos/gaming.nix
		../../modules/nixos/thunar.nix
	];

	networking.hostName = "sakithb-laptop";
	time.timeZone = "Asia/Colombo";

	environment.systemPackages = with pkgs; [
	];

	system.stateVersion = "25.11";
}
