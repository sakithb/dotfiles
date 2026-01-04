{
  pkgs,
  ...
}:

{
  imports = [
    ./modules/bash.nix
    ./modules/niri.nix
    # ./modules/quickshell.nix
    ./modules/dms.nix
    ./modules/nvim.nix
    ./modules/git.nix
    ./modules/alacritty.nix
  ];

  programs = {
    gh = {
      enable = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home = {
    username = "sakithb";
    homeDirectory = "/home/sakithb";

    packages = with pkgs; [
      brave
      slack
      pcmanfm
      xarchiver
    ];

	file = {
		"Pictures/Wallpapers" = {
			source = ./configs/wallpapers;
		};
	};

	sessionVariables = {
		Q_ICON_THEME_FALLBACK_THEME = "Papirus-Dark";
		QT_QPA_PLATFORMTHEME = "gtk3";
	};

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
