{ config, pkgs, ... }:

{
  home.file = {
    "Pictures/Wallpapers" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/configs/wallpapers";
    };
  };
}
