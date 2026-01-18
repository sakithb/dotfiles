{ ... }:

{
  programs = {
    steam = {
      enable = true;
    };

    gamemode = {
      enable = true;
      enableRenice = true;

      settings = {
        general = {
          renice = 10;
        };
      };
    };
  };
}
