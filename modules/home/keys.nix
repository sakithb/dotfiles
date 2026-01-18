{
  pkgs,
  ...
}:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;

    pinentry = {
      package = pkgs.pinentry-gnome3;
    };

    defaultCacheTtl = 7200;
    defaultCacheTtlSsh = 7200;

    sshKeys = [
      "07EFCC9716BFB13DDBDB2CF2C961D9290C3BCEFF"
    ];
  };
}
