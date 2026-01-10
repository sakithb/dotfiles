{ inputs, ... }:

{
  imports = [
    inputs.dms.nixosModules.greeter
  ];

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/sakithb";
  };
}
