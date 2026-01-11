{ ... }:

{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
		# tap_time = 200;
		#       capslock = "overload(control, esc)";
        leftmeta = "overload(meta, f13)";
        # leftmouse = "leftmouse";
        # rightmouse = "rightmouse";
      };
    };
  };
}
