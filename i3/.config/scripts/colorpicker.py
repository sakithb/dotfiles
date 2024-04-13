#!/bin/env python3

from os import system
from subprocess import getoutput

color_info = getoutput("maim -suBt 0 | convert -'[1x1+10+10]' txt:-").split("\n")[1].split()

hex = color_info[2]
rgba = color_info[3].replace("srgb", "rgb")

if(hex == "decode"):
    exit(0)

cmd = "echo -e \"{0}\n{1}\" | rofi -theme ~/.config/rofi/colorpicker.rasi -dmenu | xclip -selection clipboard".format(hex, rgba)

system(cmd)
