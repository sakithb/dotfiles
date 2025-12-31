{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./modules/bash.nix
    ./modules/niri-home.nix
    ./modules/nvim.nix
    ./modules/git.nix
    ./modules/alacritty.nix
  ];

  home = {
	  username = "sakithb";
	  homeDirectory = "/home/sakithb";

	  packages = with pkgs; [
		  alacritty
			  brave
			  slack
			  nixd
			  nixfmt-rfc-style
	  ];

	  stateVersion = "25.11";
  };
}
