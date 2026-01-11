{ ... }:

{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        # capslock = "overload(control, esc)";
        leftmeta = "overload(meta, f13)";
        # leftmouse = "leftmouse";
        # rightmouse = "rightmouse";
      };
    };
  };
}
