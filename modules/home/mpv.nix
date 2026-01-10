{ config, ... }:

{
  xdg.configFile."mpv".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/configs/mpv";

	programs.mpv = {
		enable = true;
	};
}
