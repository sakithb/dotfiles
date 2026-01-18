{ pkgs, ... }:

{
	home.packages = with pkgs; [
		gopass
	];

	programs.browserpass = {
		enable = true;
		browsers = [
			"chromium"
		];
	};
}
