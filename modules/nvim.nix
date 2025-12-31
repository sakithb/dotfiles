{ config, pkgs, ... }:

{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;

		extraWrapperArgs = [
			"--set" "RIPGREP_CONFIG_PATH" "${config.xdg.configHome}/nvim/.ripgreprc"
		];
	};

	home.packages = with pkgs; [
		ripgrep
	];

	xdg.configFile."nvim".source = ../configs/nvim;
}
