{
  config,
  ...
}:

{
	programs.quickshell = {
		enable = true;
		systemd = {
			enable = true;
			target = "niri.session";
		};
	};

  xdg.configFile."quickshell".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/configs/quickshell";
}
