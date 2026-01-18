{
  pkgs,
  lib,
  ...
}:

{
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
    baobab

    nm-connection-editor
    pavucontrol

    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
  ];

  # Theming

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

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=KvGnomeDark
  '';

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
      "text/html" = "chrome-browser.desktop";
      "x-scheme-handler/http" = "chrome-browser.desktop";
      "x-scheme-handler/https" = "chrome-browser.desktop";
      "x-scheme-handler/about" = "chrome-browser.desktop";
      "x-scheme-handler/unknown" = "chrome-browser.desktop";

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
