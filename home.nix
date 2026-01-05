{
  pkgs,
  ...
}:

{
  imports = [
    ./modules/bash.nix
    ./modules/niri.nix
    ./modules/dms.nix
    ./modules/nvim.nix
    ./modules/git.nix
    ./modules/alacritty.nix
    ./modules/qutebrowser.nix
    ./modules/theme.nix
  ];

  programs = {
    gh = {
      enable = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home = {
    username = "sakithb";
    homeDirectory = "/home/sakithb";

    packages = with pkgs; [
      brave
      slack
    ];

    stateVersion = "25.11";
  };
}
