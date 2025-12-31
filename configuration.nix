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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "i915.enable_psr=0"
  ];

  hardware.enableAllFirmware = true;

  networking.hostName = "sakithb-nixos";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;

  time.timeZone = "Asia/Colombo";

  zramSwap.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  hardware.graphics.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
  ];

  users.users.sakithb = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
  };

  programs.niri.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    binutils
    pkg-config
    wget
    curl
  ];

  system.stateVersion = "25.11";

  nix.settings = {
    max-jobs = "auto";
    cores = 2;
  };

  services.earlyoom = {
    enable = true;
    enableNotifications = true;
    freeMemThreshold = 5;
  };
}
