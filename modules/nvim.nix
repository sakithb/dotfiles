{
  config,
  pkgs,
  inputs,
  ...
}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraWrapperArgs = [
      "--set"
      "RIPGREP_CONFIG_PATH"
      "${config.xdg.configHome}/nvim/.ripgreprc"
    ];

    extraPackages = with pkgs; [
      ripgrep
      tree-sitter
    ];
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/configs/nvim";
}
