{ ... }:

{
  programs.readline = {
    enable = true;
    variables = {
      keyseq-timeout = 10;
      completion-ignore-case = true;
      completion-map-case = true;
      show-all-if-ambiguous = true;
      mark-symlinked-directories = true;
    };

    bindings = {
      "Space" = "magic-space";
      "\\e[A" = "history-search-backward";
      "\\e[B" = "history-search-forward";
      "\\e[C" = "forward-char";
      "\\e[D" = "backward-char";
    };
  };

  programs.bash = {
    enable = true;
    enableVteIntegration = true;
    enableCompletion = true;
    historyControl = [
      "erasedups"
      "ignoreboth"
    ];
    historyFileSize = 100000;
    historySize = 500000;
    historyIgnore = [
      "&"
      "[ ]*"
      "exit"
      "ls"
      "bg"
      "fg"
      "history"
      "clear"
    ];

    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      nrs = ''cd $HOME/Projects/dotfiles && git add . && sudo nixos-rebuild switch --flake . && git commit -m "$(date +%d-%m-%y_%H:%M:%S)"'';
      nfu = ''cd $HOME/Projects/dotfiles && nix flake update && nrs'';
      ngc = ''nix-collect-garbage -d'';
    };

    sessionVariables = {
      PROMPT_DIRTRIM = "2";
      HISTTIMEFORMAT = "%F %T ";
    };

    shellOptions = [
      "checkwinsize"
      "globstar"
      "nocaseglob"

      "autocd"
      "dirspell"
      "cdspell"
      "cdable_vars"
    ];

    initExtra = ''
        set -o noclobber
      	PS1='\[\e[38;5;34m\]\w\[\e[38;5;214m\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 1) \[\e[0m\]\\$ '
    '';

  };
}
