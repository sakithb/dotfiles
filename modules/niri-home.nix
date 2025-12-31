{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      colorSchemes = {
        darkMode = true;
      };
      templates = {
        gtk = true;
        qt = true;
      };
    };
  };

  xdg.configFile."niri".source = ../configs/niri;
}
