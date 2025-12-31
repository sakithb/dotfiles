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
      adw-gtk3
      papirus-icon-theme
	  thunar
    ];

    stateVersion = "25.11";
  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
