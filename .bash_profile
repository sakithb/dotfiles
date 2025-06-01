if uwsm check may-start && uwsm select; then
	exec uwsm start default
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
