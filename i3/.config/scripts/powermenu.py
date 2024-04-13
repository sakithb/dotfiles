#!/bin/env python3

import os
import subprocess

action = subprocess.getoutput("echo -e '\n\n\n\n' | rofi -theme ~/.config/rofi/powermenu.rasi -dmenu")

actions = {
    "": ["power off", "systemctl poweroff"],
    "": ["reboot","systemctl reboot"],
    "": ["logout","loginctl terminate-user cliffniff"],
    "": ["lock the computer","~/.config/scripts/lock.sh"],
    "": ["sleep the computer","systemctl suspend"]
}

if action in actions.keys():
    confirm="Confirm"
    if action not in ["", ""]:
        confirm = subprocess.getoutput("echo -e 'Confirm\nCancel' | rofi -theme ~/.config/rofi/confirm.rasi -p {0} -dmenu".format("'Are you sure you want to " + actions[action][0] + "?'"));
    if confirm=="Confirm":
        os.system(actions[action][1])