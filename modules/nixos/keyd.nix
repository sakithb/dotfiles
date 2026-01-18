{ ... }:

{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "overload(nav, esc)";

          a = "overloadt(control, a, 200)";
          s = "overloadt(alt, s, 200)";
          d = "overloadt(meta, d, 200)";
          f = "overloadt(shift, f, 200)";

          j = "overloadt(shift, j, 200)";
          k = "overloadt(meta, k, 200)";
          l = "overloadt(alt, l, 200)";
          ";" = "overloadt(control, ;, 200)";

          leftalt = "layer(toggle_layer)";
        };

        nav = {
          h = "left";
          j = "down";
          k = "up";
          l = "right";

          u = "pageup";
          d = "pagedown";

          x = "delete";
          e = "backspace";

          "0" = "home";
          "4" = "end";
        };

        "toggle_layer" = {
          esc = "toggle(gaming)";
        };

        gaming = {
          leftalt = "layer(exit_game)";
        };

        "exit_game" = {
          esc = "toggle(gaming)";
        };
      };
    };
  };
}
