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

export GOPATH="$HOME/.go"
export FLYCTL_INSTALL="/home/sakithb/.fly"
export PATH="$PATH:$GOPATH/bin:~/.local/bin/:~/.nodenv/bin:$FLYCTL_INSTALL/bin"

# Pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# Nodenv
eval "$(nodenv init -)"

. "$HOME/.cargo/env"
