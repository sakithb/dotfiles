{ pkgs, osConfig, ... }:

{
  programs.lutris = {
    enable = true;
    protonPackages = [ pkgs.proton-ge-bin ];
    winePackages = [ pkgs.wineWow64Packages.full ];
	steamPackage = osConfig.programs.steam.package;
	defaultWinePackage = pkgs.proton-ge-bin;
  };
}
