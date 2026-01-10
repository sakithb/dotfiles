{ pkgs, inputs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 0;
  boot.kernelParams = [ "i915.enable_psr=0" ];

  hardware.enableAllFirmware = true;
  hardware.bluetooth.enable = true;

  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
    persistent = true;
    randomizedDelaySec = "10min";
  };
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    inputs.niri.overlays.default
    inputs.neovim-nightly-overlay.overlays.default
  ];

  security.pam.loginLimits = [{ domain = "*"; type = "-"; item = "nofile"; value = "65536"; }];
  systemd.settings.Manager.DefaultLimitNOFILE = "65536";
  systemd.user.extraConfig = "DefaultLimitNOFILE=65536";

  services.pipewire = { enable = true; pulse.enable = true; };
  services.power-profiles-daemon.enable = true;
  services.earlyoom = { enable = true; enableNotifications = true; };
  zramSwap.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts noto-fonts-cjk-sans noto-fonts-color-emoji nerd-fonts.jetbrains-mono
  ];

  users.users.sakithb = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "gamemode" ];
  };
}
