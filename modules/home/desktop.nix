{
  pkgs,
  inputs,
  config,
  ...
}:

{
  imports = [
    inputs.dms.homeModules.dankMaterialShell.default
  ];

  home.packages = with pkgs; [
    nautilus
    loupe
    celluloid
    evince
    file-roller
    gnome-text-editor
    gnome-calculator

    resources
    gnome-disk-utility
    pavucontrol
    overskride
    (networkmanagerapplet.overrideAttrs (oldAttrs: {
      postInstall = (oldAttrs.postInstall or "") + ''
        rm $out/etc/xdg/autostart/nm-applet.desktop
      '';
    }))
    baobab

    libsForQt5.qt5ct
    kdePackages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
  ];

  # Shell and compositor

  programs.dankMaterialShell = {
    enable = true;

    plugins = {
      EmojiLauncher = {
        src = pkgs.fetchFromGitHub {
          owner = "devnullvoid";
          repo = "dms-emoji-launcher";
          rev = "2951ec7";
          sha256 = "sha256-aub5pXRMlMs7dxiv5P+/Rz/dA4weojr+SGZAItmbOvo=";
        };
      };
      CalculatorLauncher = {
        src = pkgs.fetchFromGitHub {
          owner = "rochacbruno";
          repo = "DankCalculator";
          rev = "de6dbd5";
          sha256 = "sha256-aub5pXRMlMs7dxiv5P+/Rz/dA4weojr+SGZAItmbOvo=";
        };
      };
    };
  };

  xdg.configFile."niri".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Projects/dotfiles/configs/niri";

  # Theming

  home.file = {
    "Pictures/Wallpapers" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Projects/dotfiles/configs/wallpapers";
    };
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };

    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };

  # XDG

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";

      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/png" = "org.gnome.Loupe.desktop";
      "image/gif" = "org.gnome.Loupe.desktop";
      "image/webp" = "org.gnome.Loupe.desktop";
      "image/svg+xml" = "org.gnome.Loupe.desktop";

      "video/mp4" = "io.github.celluloid_player.Celluloid.desktop";
      "video/x-matroska" = "io.github.celluloid_player.Celluloid.desktop";
      "video/webm" = "io.github.celluloid_player.Celluloid.desktop";
      "video/quicktime" = "io.github.celluloid_player.Celluloid.desktop";

      "application/pdf" = "org.gnome.Evince.desktop";

      "text/plain" = "org.gnome.TextEditor.desktop";

      "inode/directory" = "org.gnome.Nautilus.desktop";
    };
  };

}
