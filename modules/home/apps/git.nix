{ ... }:

{
  programs.git = {
    enable = true;

    aliases = {
      lazy = "!f() { git add -A && git commit -m \"$1\" && git push; }; f";
    };

    signing = {
      key = "/home/sakithb/.ssh/id_ed25519.pub";
      format = "ssh";
      signByDefault = true;
    };

    ignores = [
      ".direnv"
      ".envrc"
      ".phpactor.json"
    ];

    settings = {
      core = {
        editor = "nvr --remote-wait";
      };

      pull = {
        rebase = true;
      };

      user = {
        name = "Sakith B.";
        email = "pvsakith@gmail.com";
      };

      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };

  };
}
