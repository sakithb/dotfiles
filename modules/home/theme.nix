{ config, pkgs, ... }:

{
  home.file = {
    "Pictures/Wallpapers" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/configs/wallpapers";
    };
  };

	#  home.pointerCursor = {
	#    gtk.enable = true;
	#    x11.enable = true;
	# name = "Adwaita";
	# package = pkgs.adwaita-icon-theme;
	#    size = 16;
	#  };
	#
	#  gtk = {
	#    enable = true;
	#    colorScheme = "dark";
	#
	#    theme = {
	#      name = "Adwaita-dark";
	#      package = pkgs.gnome-themes-extra;
	#    };
	#
	#    iconTheme = {
	#      name = "Papirus-Dark";
	#      package = pkgs.papirus-icon-theme;
	#    };
	#  };
	#
	#  qt = {
	#    enable = true;
	#    platformTheme.name = "gtk";
	#  };
	#
	#  dconf.settings = {
	#    "org/gnome/desktop/interface" = {
	#      color-scheme = "prefer-dark";
	#    };
	#  };
}
