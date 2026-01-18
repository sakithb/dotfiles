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
          rightalt = "layer(command_layer)";
        };

        command_layer = {
          g = "toggle(gaming)";
        };

        gaming = {
          tab = "tab";
          capslock = "leftcontrol";

          rightalt = "layer(command_layer)";
        };

        nav = {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
          u = "pageup";
          d = "pagedown";
          x = "delete";
          w = "backspace";
          b = "home";
          e = "end";
        };
      };
    };
  };
}
