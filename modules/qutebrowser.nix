{
  config,
  pkgs,
  ...
}:

{
  # programs.qutebrowser = {
  #   enable = true;

  #   package = pkgs.qutebrowser.override {
  #     enableWideVine = true;
  #   };
  # };

  home.packages = [
    (pkgs.qutebrowser.override { enableWideVine = true; })
  ];

  xdg.configFile."qutebrowser".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/configs/qutebrowser";
}
