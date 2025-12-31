{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "i915.enable_psr=0"
    ];
  };

  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    binutils
    pkg-config
    wget
    curl
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
    graphics.enable = true;
  };

  networking = {
    hostName = "sakithb-nixos";
    networkmanager.enable = true;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    settings = {
      max-jobs = "auto";
      cores = 2;
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs.niri.enable = true;

  services = {
    tuned.enable = true;
    upower.enable = true;
    libinput.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    earlyoom = {
      enable = true;
      enableNotifications = true;
      freeMemThreshold = 5;
    };
    openssh.enable = true;
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "overload(control, esc)";
            };
          };
        };
      };
    };
  };

  system.stateVersion = "25.11";

  time.timeZone = "Asia/Colombo";

  users.users.sakithb = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
  };

  zramSwap.enable = true;
}
