{
  inputs,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    inputs.dms.nixosModules.greeter
  ];

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/sakithb";
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
      postInstall = (old.postInstall or "") + ''
        wrapProgram $out/bin/niri \
          --prefix PATH : ${lib.makeBinPath [ pkgs.xwayland-satellite ]}
      '';
    });
  };

  services = {
    gvfs.enable = true;
    udisks2.enable = true;
  };
}
