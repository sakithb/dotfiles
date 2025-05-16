if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
