#!/bin/env python3

from os import system
from subprocess import getoutput

action = getoutput("echo -e \"Set timer\nWait for a process to finish\" | rofi -p  -lines 2 -theme ~/.config/rofi/text_list.rasi -dmenu")
time_amount = None
process_id = None
process_name = None

if action == "Set timer":
    time_choice = getoutput("echo -e \"1 hour\n2 hours\nCustom\" | rofi -p  -lines 3 -theme ~/.config/rofi/text_list.rasi -dmenu")
    if time_choice == "1 hour":
        time_amount = 3600
    elif time_choice == "2 hours":
        time_amount = 7200
    else:
        # TODO: Show input bar
        pass
elif action == "Wait for a process to finish":
    process_list = getoutput("ps -u cliffniff").split("\n")
    new_process_list = {}
    for process in process_list:
        process_info = process.split()
        new_process_list[process_info[-1]] = process_info[0]
    del new_process_list["CMD"]
    process_name = getoutput("echo -e \"{0}\" | rofi -p  -lines 8 -theme ~/.config/rofi/text_list_with_input.rasi -dmenu".format("\n".join(new_process_list.keys())))
    process_id = new_process_list[process_name]
else:
    exit(0)

quit_action = getoutput("echo -e \"Shutdown\nSuspend\nRestart\nNothing\" | rofi -p  -lines 4 -theme ~/.config/rofi/text_list.rasi -dmenu")

cmd = "~/.cargo/bin/caffeinate {0} {1} &".format("-t {0}".format(time_amount) if time_amount is not None else "-p {0}".format(process_id), "-q {0}".format(quit_action.lower()))
system(cmd)

if time_amount is not None:
    abbr_0 = "for"
    if time_amount < 3600:
        abbr_1 = "{0} minutes".format(time_amount / 60)
    else:
        no_of_hours = round(time_amount / 3600)
        no_of_minutes = time_amount % 3600
        abbr_1 = "{0} hour(s){1}".format(no_of_hours, " and {0} minute(s)".format(no_of_minutes) if no_of_minutes > 0 else "")
else:
    abbr_0 = "until"
    abbr_1 = "the process quits and \"{0}\" ".format(process_name)

abbr_2 = quit_action if quit_action != "Nothing" else ""

system("dunstify -i dialog-information \"The system will stay awake {0} {1} {2}\" &".format(abbr_0, abbr_1, abbr_2))
    