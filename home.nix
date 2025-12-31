{ config, pkgs, inputs, ... }:

{
	imports = [
		./modules/bash.nix
		./modules/niri-home.nix
		./modules/nvim.nix
		./modules/git.nix
		./modules/alacritty.nix
	];

	home.username = "sakithb";
	home.homeDirectory = "/home/sakithb";

	home.packages = with pkgs; [
		alacritty
		brave
		slack
	];

	home.stateVersion = "25.11";
}
