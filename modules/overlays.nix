{ ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      niri = prev.lib.pipe prev.niri [
        (
          pkg:
          pkg.override {
            withScreencastSupport = false;
          }
        )

        (
          pkg:
          pkg.overrideAttrs (old: {
            nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ prev.makeWrapper ];
            postInstall = (old.postInstall or "") + ''
              wrapProgram $out/bin/niri \
                --prefix PATH : ${prev.lib.makeBinPath [ prev.xwayland-satellite ]}
            '';
          })
        )
      ];

      nm-connection-editor = prev.networkmanagerapplet.overrideAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
          rm $out/etc/xdg/autostart/nm-applet.desktop
        '';
      });

      steam = prev.steam.override {
        extraArgs = "-system-composer";
      };

      ungoogled-chromium = prev.ungoogled-chromium.override {
        enableWideVine = true;
      };
    })
  ];
}
