{ config, pkgs, ... }:

{
  home.file = {
    "Pictures/Wallpapers" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/configs/wallpapers";
    };
  };

  home.file.".local/share/icons/Papirus-Dark" = {
	  source = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
  };

  home.packages = with pkgs; [
    adw-gtk3
    kdePackages.qt6ct
	papirus-icon-theme
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Adwaita";
    package = pkgs.capitaine-cursors;
    size = 16;
  };

  home.sessionVariables = {
	  QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  # gtk = {
  #   enable = true;
  #   colorScheme = "dark";
  #
  #   theme = {
  #     name = "Adwaita-dark";
  #     package = pkgs.gnome-themes-extra;
  #   };
  #
  #   iconTheme = {
  #     name = "Papirus-Dark";
  #     package = pkgs.papirus-icon-theme;
  #   };
  # };
  #
  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk";
  # };
  #
  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     color-scheme = "prefer-dark";
  #   };
  # };
}
