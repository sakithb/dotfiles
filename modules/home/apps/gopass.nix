{ pkgs, ... }:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;

    pinentry = {
      package = pkgs.pinentry-gnome3;
    };

    defaultCacheTtl = 7200;
    defaultCacheTtlSsh = 7200;
  };

  home.packages = with pkgs; [
    gopass
  ];

  programs.browserpass = {
    enable = true;
    browsers = [
      "chromium"
    ];
  };
}
