{ pkgs, ... }:

let
  dir = ./.;
  files = builtins.readDir dir;
  nixFiles = builtins.filter (
    name: files.${name} == "regular" && name != "default.nix" && builtins.match ".*\\.nix" name != null
  ) (builtins.attrNames files);

in
{
  imports = map (name: dir + "/${name}") nixFiles;

  home.packages = with pkgs; [
	# day to day
	google-chrome
    protonvpn-gui
    anydesk

	# work
    slack

	# school
	libreoffice

	# gaming
	lutris
	
	# dev
	dbeaver-bin
  ];
}
