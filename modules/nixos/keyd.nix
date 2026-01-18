{ ... }:

{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "overload(ctrl, capslock)";
          shift = "overload(shift, esc)";
          tab = "overload(nav, tab)";
        };
		
		nav = {
		  h = "left";
		  j = "down";
		  k = "up";
		  l = "right";
		};
      };
    };
  };
}
