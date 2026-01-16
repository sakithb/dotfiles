{ ... }:

{
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
    daemon.settings = {
		dns = ["172.17.0.1"];
		min-api-version = "1.24";
	};
  };
}
