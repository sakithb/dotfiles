{ config, pkgs, ... }:

{
	programs.bash = {
		enable = true;
		enableVteIntegration = true;
		historyControl = [ "erasedups" "ignoreboth" ];
		historyFileSize = 100000;
		historySize = 500000;
		historyIgnore = [ "&" "[ ]*" "exit" "ls" "bg" "fg" "history" "clear" ];

		shellAliases = {
			ls = "ls --color=auto";
			grep = "grep --color=auto";
			nrs = "cd $HOME/projects/dotfiles && git add . && git commit -m \"$(date +%d-%m-%y_%H:%M:%S)\" && sudo nixos-rebuild switch --flake .";
		};

		sessionVariables = {
			EDITOR = "nvim";
		};

		initExtra = ''
      # =======================================================
      # Sensible Bash Defaults
      # =======================================================
      
      # General Options
      set -o noclobber
      shopt -s checkwinsize
      PROMPT_DIRTRIM=2
      bind Space:magic-space
      shopt -s globstar 2> /dev/null
      shopt -s nocaseglob

      # Smarter Tab-Completion
      bind "set completion-ignore-case on"
      bind "set completion-map-case on"
      bind "set show-all-if-ambiguous on"
      bind "set mark-symlinked-directories on"

      # Better Directory Navigation
      shopt -s autocd 2> /dev/null
      shopt -s dirspell 2> /dev/null
      shopt -s cdspell 2> /dev/null
      shopt -s cdable_vars
      
      # History Time Format
      HISTTIMEFORMAT='%F %T '
      
      # Incremental Search Bindings
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
      bind '"\e[C": forward-char'
      bind '"\e[D": backward-char'

      # =======================================================
      # Custom Prompt & Init
      # =======================================================
      
      PS1='\[\e[38;5;34m\]\w\[\e[38;5;214m\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 1) \[\e[0m\]\\$ '
    '';
	};
}
