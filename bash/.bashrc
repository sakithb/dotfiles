[[ $- != *i* ]] && return

#==============================================================================

# Sensible Bash - An attempt at saner Bash defaults
# Maintainer: mrzool <http://mrzool.cc>
# Repository: https://github.com/mrzool/bash-sensible
# Version: 0.2.2

## GENERAL OPTIONS ##

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

## SMARTER TAB-COMPLETION (Readline bindings) ##

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

#==============================================================================

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[38;5;34m\]\w\[\e[38;5;214m\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 1) \[\e[0m\]\\$ '

export EDITOR="vim"

export ppsn="$HOME/Projects/personal"
export pwrk="$HOME/Projects/work"
export poth="$HOME/Projects/other"
export ptmp="$HOME/Projects/temp"

export PATH="$PATH:$HOME/.local/share/bin:$HOME/.local/bin:$HOME/Projects/scripts"

# Go
export GOPATH="$HOME/.local/share/go"
export PATH="$PATH:$GOPATH/bin"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PATH:$PNPM_HOME"

# nvm
nvm_cmd() {
    [ -z "$NVM_DIR" ] && {
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    }
}

alias nvm="nvm_cmd; nvm"
alias node="nvm_cmd; node"
alias npm="nvm_cmd; npm"

# emsdk
export EMSDK="$HOME/.emsdk"
export EMSDK_NODE=$(which node)
export PATH="$PATH:$HOME/.emsdk:$HOME/.emsdk/upstream/emscripten"

# turso
export PATH="$PATH:/home/sakithb/.turso"
####################
# Added by sway-wsl2
####################

# Set environment variables when running sway
if [[ $XDG_SESSION_DESKTOP == "sway" ]]; then
  # Default browser is "wslview"
  export BROWSER=firefox

  # Allows xdg-open to open programs within the VM, instead of windows
  export DE=generic

  # Allow VSCode to open within the VM instead of telling you to install it on windows
  export DONT_PROMPT_WSL_INSTALL=1

  # Uncomment to get kitty working. GTK_USE_PORTAL may break some other things so I left it disabled for now
  # Kitty is low resolution in WSL2 though for some reason? Would stick to xfce4-terminal or another terminal emulator
  # export GTK_USE_PORTAL=1
  # export LIBGL_ALWAYS_INDIRECT=0
  # export GALLIUM_DRIVER=llvmpipe
fi

