{ pkgs, lib, ... }:

{
  programs.niri = {
    enable = true;
    package = pkgs.niri.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
      postInstall = (old.postInstall or "") + ''
        wrapProgram $out/bin/niri \
          --prefix PATH : ${lib.makeBinPath [ pkgs.xwayland-satellite ]}
      '';
    });
  };
}
