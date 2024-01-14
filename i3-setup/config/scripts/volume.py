#!/bin/env python3

import sys
import os
import subprocess

id="323232344"

action = sys.argv[1]

def notify():
    volume = int(subprocess.getoutput("ponymix get-volume"))

    if volume < 30:
        vicon = 'audio-volume-low'
    elif volume < 70:
        vicon = 'audio-volume-medium'
    else:
        vicon = 'audio-volume-high'
    
    if action == "mute":
        mute = subprocess.getoutput("amixer -c 0 get Master | tail -1 | awk '{print $6}' | sed 's/[^a-z]*//g'")
        print(mute)
        os.system("dunstify -t 1500 -r {0} -i '{1}' '{2}'".format(id, "audio-volume-muted" if mute == "off" else vicon, "Speakers muted" if mute == "off" else "Speakers unmuted"))
    else:
        os.system("dunstify -t 1500 -r {1} -i {2} -h string:x-dunst-stack-tag:audio  'Volume' -h int:value:{0}".format(volume, id, vicon))


if action == "up":
    # increase
    os.system('ponymix increase 5')
elif action == "down":
    # decrease
    os.system('ponymix decrease 5')
elif action == "mute":
    # mute
    os.system('ponymix toggle')

notify()
os.system('canberra-gtk-play -i audio-volume-change -d "changeVolume"')