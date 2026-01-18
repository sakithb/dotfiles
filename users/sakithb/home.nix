{ lib, ... }:

{
  imports = [
    ../../modules/home/desktop.nix
    ../../modules/home/misc.nix
    ../../modules/home/keys.nix
    ../../modules/home/nixpkgs.nix

    ../../modules/home/apps
  ];

  home.username = "sakithb";
  home.homeDirectory = "/home/sakithb";

  home.sessionVariables = {
    EDITOR = "nvim";
    PROJECTS = "$HOME/Projects";
	PASSWORD_STORE_DIR = "$HOME/.password-store";
  };

  home.shellAliases = {
    ls = "ls --color=auto";
    grep = "grep --color=auto";
    nrs = ''cd $PROJECTS/dotfiles && git add . && sudo nixos-rebuild switch --flake . && git commit -m "$(date +%d-%m-%y_%H:%M:%S)"'';
    nfu = ''cd $PROJECTS/dotfiles && nix flake update && nrs'';
    ngc = ''nix-collect-garbage -d'';
  };

  home.activation = {
    symlinks = lib.mkAfter ''
      		ln -sf $PROJECTS/dotfiles/configs/dms/settings.json $HOME/.config/DankMaterialShell/settings.json
      		ln -sf $PROJECTS/dotfiles/configs/dms/plugin_settings.json $HOME/.config/DankMaterialShell/plugin_settings.json
      		ln -sf $PROJECTS/dotfiles/configs/niri $HOME/.config/niri
      		ln -sf $PROJECTS/dotfiles/configs/wallpapers $HOME/Pictures/Wallpapers

      		ln -sf $PROJECTS/dotfiles/configs/nvim $HOME/.config/nvim
      	'';
  };

  home.stateVersion = "25.11";
}
