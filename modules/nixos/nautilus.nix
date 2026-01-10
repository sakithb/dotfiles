{ pkgs, ... }:

{
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  environment.systemPackages = with pkgs; [
  	nautilus
	file-roller
	sushi
  ];
}
