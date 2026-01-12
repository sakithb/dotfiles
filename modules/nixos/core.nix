{ pkgs, inputs, ... }:

{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };

      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [ "ntfs" ];

    kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 0;
    kernelParams = [ "i915.enable_psr=0" ];
  };

  networking = {
    networkmanager = {
      enable = true;
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
      persistent = true;
      randomizedDelaySec = "10min";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      # inputs.niri.overlays.default
      inputs.neovim-nightly-overlay.overlays.default
    ];
  };

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "-";
      item = "nofile";
      value = "65536";
    }
  ];

  systemd = {
    settings.Manager.DefaultLimitNOFILE = "65536";
    user.extraConfig = "DefaultLimitNOFILE=65536";
  };

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    power-profiles-daemon.enable = true;
    earlyoom = {
      enable = true;
      enableNotifications = true;
    };
  };

  fonts = {
    packages = with pkgs; [
      inter
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Inter" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };

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
