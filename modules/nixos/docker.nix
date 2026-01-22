{ ... }:

{
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
    daemon.settings = {
      min-api-version = "1.24";
      # dns = [ "10.0.2.3" ];
    };
  };
}
