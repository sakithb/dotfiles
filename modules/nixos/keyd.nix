{ ... }:

{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        capslock = "overloadt(control, esc, 200)";
        leftmeta = "overloadt(meta, f13, 200)";
      };
    };
  };
}
