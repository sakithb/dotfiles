{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.dms.homeModules.dankMaterialShell.default
  ];

  programs.dankMaterialShell = {
    enable = true;
  };
}
