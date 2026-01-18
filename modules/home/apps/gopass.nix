{ pkgs, ... }:

{
	home.packages = with pkgs; [
		gopass
		passExtensions.pass-import
	];
}
