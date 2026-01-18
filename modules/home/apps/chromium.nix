{
  pkgs,
  ...
}:

{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;

    commandLineArgs = [
      "--extension-mime-request-handling=always-prompt-for-install"
      "--profile-directory=Default"
    ];
  };
}
