{ ... }:

{
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
    daemon.settings.min-api-version = "1.24";
  };
}
