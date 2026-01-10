{ ... }:

{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        capslock = "overload(control, esc)";
        leftmeta = "overload(meta, M-space)";
        leftmouse = "leftmouse";
        rightmouse = "rightmouse";
      };
    };
  };
}
