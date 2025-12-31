{ config, pkgs, inputs, ... }:

{
	imports = [
		inputs.noctalia.homeModules.default
	];

	programs.noctalia-shell.enable = true;

	programs.bash = {
		enable = true;
		profileExtra = ''
      if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec niri-session
      fi
    '';
	};
}
