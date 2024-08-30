# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[38;5;34m\]\w\[\e[38;5;214m\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 1) \[\e[0m\]\\$ '

# Sensible defaults
if [ -f ~/.bashrc.sensible ]; then
   source ~/.bashrc.sensible
fi

# Aliases
alias cdp="cd ~/Projects/personal"
alias cdw="cd ~/Projects/work"
alias cdt="cd ~/Projects/temp"
alias cdpt="cdp && cd"
alias cdwt="cdw && cd"
alias cdtt="cdt && cd"

export PATH="$PATH:~/Projects/scripts"

# nodenv
eval "$(nodenv init -)"

# pnpm
export PNPM_HOME="/home/sakithb/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
