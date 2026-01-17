{
  pkgs,
  lib,
  config,
  ...
}:

{
  programs.chromium =
    let
      package = pkgs.ungoogled-chromium;
      installExtensions = false;
    in
    {
      inherit package;

      enable = true;

      commandLineArgs = [
        "--extension-mime-request-handling=always-prompt-for-install"
      ]
      ++ lib.optionals installExtensions (
        [
          "https://github.com/NeverDecaf/chromium-web-store/releases/latest/download/Chromium.Web.Store.crx"
        ]
        ++ map (
          extension:
          "https://clients2.google.com/service/update2/crx?response=redirect\\&acceptformat=crx2,crx3\\&prodversion=${package.version}\\&x=id%3D${extension.id}%26uc"
        ) config.programs.chromium.extensions
      );

      extensions = [
        {
          # I still don't care about cookies
          id = "edibdbjcniadpccecjdfdjjppcpchdlm";
        }
        {
          # KeePassXC-Browser
          id = "oboonakemofpalcgghocfoadofidjkkk";
        }
        {
          # Privacy Badger
          id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp";
        }
        {
          # Refined GitHub
          id = "hlepfoohegkhhmjieoechaddaejaokhf";
        }
        {
          # uBlock Origin Lite
          id = "ddkjiahejlhfcafbddmgiahcphecmpfh";
        }
        {
          # Wayback Machine
          id = "fpnmgdkabkmnadcjpehmlllkndpkmiak";
        }
      ];
    };
}
