if uwsm check may-start -q; then
    exec uwsm start hyprland.desktop
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
