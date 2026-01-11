{ ... }:

{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        capslock = "overload(control, esc)";
        leftmeta = "overload(meta, f24)";
        leftmouse = "leftmouse";
        rightmouse = "rightmouse";
      };
    };
  };
}
