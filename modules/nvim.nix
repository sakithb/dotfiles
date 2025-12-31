{
  config,
  pkgs,
  inputs,
  ...
}:

{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
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
    config.lib.file.mkOutOfStoreSymlink "/home/sakithb/projects/dotfiles/configs/nvim";
}
