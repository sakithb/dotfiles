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
		EDITOR="nvim";
		PROJECTS="$HOME/Projects";
	};

  home.stateVersion = "25.11";
}
