{ ... }:

{
  programs.git = {
    enable = true;

    signing = {
      key = "C404859B57D9F8895C61A956F94060A80A23542B";
      signByDefault = true;
    };

    ignores = [
      ".direnv"
      ".envrc"
      ".phpactor.json"
    ];

    settings = {
      commit = {
        gpgsign = true;
      };

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
