{ config, pkgs, ... }:

{
	programs.git = {
		enable = true;

		user = {
			name = "Sakith B.";
			email = "pvsakith@gmail.com";
		};

		signing = {
			key = "/home/sakithb/.ssh/id_ed25519.pub";
			signByDefault = true;
		};

		settings = {
			pull = {
				rebase = true;
			};
			gpg = {
				format = "ssh";
			};
		};

	};
}
