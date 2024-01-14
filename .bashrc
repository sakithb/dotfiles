#
# ~/.bashrc
#

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
alias cds="cd ~/Projects/solo"
alias cdc="cd ~/Projects/clones"
alias cdw="cd ~/Projects/work"
alias cdp="cd ~/Projects/play"
alias cdst="cds && cd"
alias cdct="cdc && cd"
alias cdwt="cdw && cd"
alias cdpt="cds && cd"t="cdp && cd"
alias code="com.visualstudio.code"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Nodenv
eval "$(nodenv init -)"

# pnpm
export PNPM_HOME="/home/sakithb/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
