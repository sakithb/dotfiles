{ ... }:

{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "overload(control, esc)";
          tab = "overload(nav, tab)";
        };
		
		nav = {
		  h = "left";
		  j = "down";
		  k = "up";
		  l = "right";
		  u = "pageup";
		  d = "pagedown";
		};
      };
    };
  };
}
