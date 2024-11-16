# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[38;5;34m\]\w\[\e[38;5;214m\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 1) \[\e[0m\]\\$ '

# Sensible defaults
if [ -f ~/.bashrc.sensible ]; then
   source ~/.bashrc.sensible
fi

export EDITOR="vim"

# Aliases
alias cdp="cd $HOME/Projects/personal"
alias cdw="cd $HOME/Projects/work"
alias cdt="cd $HOME/Projects/temp"
alias cdpt="cdp && cd"
alias cdwt="cdw && cd"
alias cdtt="cdt && cd"
alias ts="tmux-sessionizer"
alias nt="ts ~/Projects/personal/notes"

if [ -f ~/Projects/personal/notes/todo.txt ]; then
	echo -e "$(cat ~/Projects/personal/notes/todo.txt)\n"
fi

export PATH="$PATH:$HOME/Projects/scripts"

# Go
export GOPATH="$HOME/.local/share/go"
export PATH="$PATH:$GOPATH/bin"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PATH:$PNPM_HOME"

# nodenv
eval "$(nodenv init -)"

