{ ... }:

{
  programs.git = {
    enable = true;

    signing = {
      key = "/home/sakithb/.ssh/id_ed25519.pub";
      signByDefault = true;
      format = "ssh";
    };

	ignores = [
		".direnv"
		".envrc"
	];

    settings = {
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
