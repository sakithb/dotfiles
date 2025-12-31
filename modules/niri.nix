{
  config,
  ...
}:

{
  xdg.configFile."niri".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/configs/niri";
}
