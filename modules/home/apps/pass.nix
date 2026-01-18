{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gopass
    gopass-jsonapi
    passExtensions.pass-import
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;

    defaultCacheTtl = 7200;
    defaultCacheTtlSsh = 7200;

    extraConfig = ''
      no-grab
    '';
  };

  home.sessionVariables = {
    PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
    GPG_TTY = "$(tty)";
  };

  programs.git.extraConfig.credential.helper = "gopass";
}
