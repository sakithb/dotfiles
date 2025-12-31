{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      php = pkgs.php84.buildEnv {
        extensions = (
          { enabled, all }:
          enabled
          ++ (with all; [
            imagick
            apcu
          ])
        );
      };

      composer = pkgs.php84Packages.composer.override {
        php = php;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.nodejs_22

          php
          composer
        ];
      };
    };
}
