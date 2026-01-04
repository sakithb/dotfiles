{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.dms.nixosModules.greeter
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [ "ntfs" ];

    kernel.sysctl = {
      "net.ipv4.ip_unprivileged_port_start" = 0;
    };

    kernelParams = [
      "i915.enable_psr=0"
    ];
  };

  environment.systemPackages = with pkgs; [
    p7zip-rar
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
  ];

  hardware = {
    enableAllFirmware = true;
    bluetooth.enable = true;
  };

  networking = {
    hostName = "sakithb-nixos";
    networkmanager = {
      enable = true;
    };
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
    persistent = true;
    randomizedDelaySec = "10min";
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    niri = {
      enable = true;
      package = pkgs.niri.overrideAttrs (old: {
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
        postInstall = (old.postInstall or "") + ''
          wrapProgram $out/bin/niri \
            --prefix PATH : ${lib.makeBinPath [ pkgs.xwayland-satellite ]}
        '';
      });
    };

    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraArgs = "-system-composer";
      };
    };

    gamemode = {
      enable = true;
      enableRenice = true;

      settings = {
        general = {
          renice = 10;
        };
      };
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    dankMaterialShell.greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/sakithb";
    };
  };

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "-";
      item = "nofile";
      value = "65536";
    }
  ];

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "overload(control, esc)";
              leftmeta = "overload(meta, M-space)";

              leftmouse = "leftmouse";
              rightmouse = "rightmouse";
            };
          };
        };
      };
    };
  };

  system.stateVersion = "25.11";

  systemd = {
    settings.Manager = {
      DefaultLimitNOFILE = "65536";
    };

    user.extraConfig = ''DefaultLimitNOFILE=65536'';
  };

  virtualisation = {
    docker.rootless = {
      enable = true;
      setSocketVariable = true;

      daemon.settings = {
        min-api-version = "1.24";
      };
    };
  };

  time.timeZone = "Asia/Colombo";

  users.users.sakithb = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "gamemode"
    ];
  };

  zramSwap.enable = true;
}
