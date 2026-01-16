{ ... }:

{
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
    daemon.settings = {
		min-api-version = "1.24";
		dns = [ "1.1.1.1" "1.0.0.1" ];
	};
  };
}
