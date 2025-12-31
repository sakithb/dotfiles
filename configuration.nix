{ config, lib, pkgs, ... }:

{
	imports =
		[ 
		./hardware-configuration.nix
		];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	boot.kernelPackages = pkgs.linuxPackages_latest;

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
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	hardware.graphics.enable = true;

	fonts.packages = with pkgs; [
		noto-fonts
			noto-fonts-cjk-sans
			noto-fonts-color-emoji
			nerd-fonts.jetbrains-mono
	];

	users.users.sakithb = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" "video" ]; 
	};

	programs.niri.enable = true;

	nixpkgs.config.allowUnfree = true;

	services.openssh.enable = true;

	system.stateVersion = "25.11";

}

