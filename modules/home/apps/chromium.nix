{
  pkgs,
  lib,
  ...
}:

{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium.override {
      enableWideVine = true;
    };

    commandLineArgs = [
      "--extension-mime-request-handling=always-prompt-for-install"
    ];
  };
}
