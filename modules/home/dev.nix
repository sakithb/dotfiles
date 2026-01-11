{ ... }:

{
  programs.gh.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
