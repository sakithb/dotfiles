{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		niri = {
			url = "github:sodiboo/niri-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		noctalia = {
			url = "github:noctalia-dev/noctalia-shell";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	outputs = inputs@{ self, nixpkgs, home-manager, niri, ... }: {
		nixosConfigurations.sakithb-nixos = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix 

				niri.nixosModules.niri
				{
					nixpkgs.overlays = [ niri.overlays.niri ];
				}

				home-manager.nixosModules.home-manager{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.extraSpecialArgs = { inherit inputs; };
					home-manager.backupFileExtension = "backup";
					home-manager.users.sakithb = import ./home.nix;
				}
			];
		};
	};
}

