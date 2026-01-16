{
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
  ];

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

  programs.dms-shell = {
    enable = true;

    plugins = {
      EmojiLauncher = {
        src = pkgs.fetchFromGitHub {
          owner = "devnullvoid";
          repo = "dms-emoji-launcher";
          rev = "2951ec7";
          sha256 = "sha256-aub5pXRMlMs7dxiv5P+/Rz/dA4weojr+SGZAItmbOvo=";
        };
      };
      CalculatorLauncher = {
        src = pkgs.fetchFromGitHub {
          owner = "rochacbruno";
          repo = "DankCalculator";
          rev = "de6dbd5";
          sha256 = "sha256-aub5pXRMlMs7dxiv5P+/Rz/dA4weojr+SGZAItmbOvo=";
        };
      };
    };

    systemd = {
      enable = true;
      restartIfChanged = true;
    };
  };

  programs.dsearch = {
    enable = true;
    systemd.enable = true;
  };

  services = {
    displayManager.dms-greeter = {
      enable = true;
      configHome = "/home/sakithb";
      compositor = {
        name = "niri";
		customConfig = ''
			hotkey-overlay {
				skip-at-startup
			}

			cursor {
				xcursor-theme "Adwaita"
				xcursor-size 24
			}
		'';
      };
    };

    gnome.sushi.enable = true;
	# flatpak.enable = true;

    gvfs.enable = true;
    udisks2.enable = true;
  };
}
