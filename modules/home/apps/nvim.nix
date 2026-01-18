{
  config,
  pkgs,
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
      nixd
      nixfmt
      lua-language-server
      typescript-language-server
      svelte-language-server
      phpactor
      bash-language-server
      ols
      qt6Packages.qtdeclarative
      python313Packages.python-lsp-server
    ];
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "$PROJECTS/dotfiles/configs/nvim";
}
