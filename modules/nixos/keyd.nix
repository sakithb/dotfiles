{ ... }:

{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        shift = "oneshot(shift)";
        meta = "oneshot(meta)";
        control = "oneshot(control)";

        leftalt = "oneshot(alt)";
        rightalt = "oneshot(altgr)";
        capslock = "overloadt(control, esc, 200)";
        leftmeta = "overloadt(meta, f13, 200)";
      };
    };
  };
}
