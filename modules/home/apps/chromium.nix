{
  pkgs,
  lib,
  ...
}:

let
  browserPkg = pkgs.ungoogled-chromium.override {
    enableWideVine = true;
  };

  browserVer = lib.versions.major browserPkg.version;

  createExtension =
    {
      id,
      sha256,
      version,
    }:
    {
      inherit id;
      crxPath = pkgs.fetchurl {
        url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVer}&x=id%3D${id}%26installsource%3Dondemand%26uc";
        name = "${id}.crx";
        inherit sha256;
      };
      inherit version;
    };
in
{
  programs.chromium = {
    enable = true;
    package = browserPkg;

    commandLineArgs = [
      "--extension-mime-request-handling=always-prompt-for-install"
    ];

    extensions = [
      (createExtension {
        # ublock origin
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
        sha256 = "sha256-w4o5W5ZMUUXmCJ+R8z2e5mGfjGOxf22Yo1DYlE9Bal0=";
        version = "1.68.0";
      })
      (createExtension {
        # dark reader
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
        sha256 = "sha256-aCAGePzaywNfNUwqSqhsM+GifJPz+NT71RiT0Z6QMkI=";
        version = "4.9.118";
      })
    ];
  };
}
