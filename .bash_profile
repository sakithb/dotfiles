if uwsm check may-start && uwsm select; then
	exec uwsm start hyprland.desktop
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
