#!/bin/env python3

from sys import argv
from subprocess import getoutput
from datetime import datetime
from os import system

path = datetime.now().strftime("Screenshot_%m-%d-%Y_%M%S.png")

actions = {
    "default": "maim /tmp/{0}; cat /tmp/{0} | xclip -selection clipboard -t image/png;mv /tmp/{0} ~/Pictures/Screenshots/{0}; ",
    "window": "maim -Bi " + getoutput("xdotool getactivewindow") + " /tmp/{0}; cat /tmp/{0} | xclip -selection clipboard -t image/png;mv /tmp/{0} ~/Pictures/Screenshots/{0} ",
    "area": "maim -Bs /tmp/{0}; cat /tmp/{0} | xclip -selection clipboard -t image/png;mv /tmp/{0} ~/Pictures/Screenshots/{0}"
}

try:
    action = argv[1]
    
except:
    action = "default"

system(actions[action].format(path))
user_action = getoutput("dunstify -A 'view,View Image' -I ~/Pictures/Screenshots/{0} 'Screenshot captured' 'Screenshot saved to {0}'".format(path))

if user_action == "view":
    system("viewnior ~/Pictures/Screenshots/{0}".format(path))