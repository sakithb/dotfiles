{
  config,
  pkgs,
  ...
}:

{
  home.packages = [
    (pkgs.qutebrowser.override { enableWideVine = true; })
  ];

  xdg.configFile."qutebrowser".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/configs/qutebrowser";
}
