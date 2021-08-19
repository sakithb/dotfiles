#!/bin/env python3

from os import system
from subprocess import Popen, PIPE, getoutput
from time import sleep
from sys import argv

flags = {
    "-w": "assign_workspace",
    "-t": "set_as_tiling"
}

commands = {
    "assign_workspace": [
        "move to scratchpad",
        "move container to workspace {0}"
    ],
    "set_as_tiling": [
        "floating disable",
    ]
}

def get_props():
    # getoutput("xprop WM_CLASS").split()
    xprop_process = Popen(["xprop", "WM_CLASS", "_NET_WM_WINDOW_TYPE"], stdout=PIPE)
    xprop_process.wait()
    wm_props, err = xprop_process.communicate()
    try:
        if err is not None:
            raise Exception(err)
        else:
            wm_props = wm_props.decode('ascii')
            wm_props_arr = wm_props.split("\n")
            if "WM_CLASS:  not found" in wm_props_arr[0]:
                raise Exception("No class found on window")
            else:

                if "_NET_WM_WINDOW_TYPE: not found" in wm_props_arr[1]:
                    wm_type = "\"normal\""
                else:
                    wm_type = "\"" + wm_props_arr[1].split()[-1].split("_")[-1].lower() + "\""

                wm_props_arr_classes = wm_props_arr[0].split()
                wm_class = wm_props_arr_classes[-1].strip()
                wm_instance = wm_props_arr_classes[-2][0:-1].strip()

                return wm_class, wm_instance, wm_type
    except Exception as e:
        return e


def exit_f(code, reason="Everything is fine"):
    print(reason)
    if code != 0:
        system("dunstify -i \"dialog-information\" \"Error while adding new rule.\"")
    else:
        system("dunstify -i \"dialog-information\" \"New rule added successfully.\"")
        system("i3-msg restart")
    exit(code)

def get_rule_props(ref_id):
    if ref_id == "set_as_tiling":
        print("set_as_tiling")
        return commands["set_as_tiling"][0], None
    elif ref_id == "assign_workspace":
        workspace_id = getoutput(
                                    "echo -e \"Workspace 1\nWorkspace 2\nWorkspace 3\nWorkspace 4\nWorkspace 5\nWorkspace 6\nWorkspace 7\nWorkspace 8\nWorkspace 9\nWorkspace 10\nScratchpad\" | rofi -p  -lines 11 -theme ~/.config/rofi/text_list_with_input.rasi -dmenu"
                                )
        if workspace_id == "":
            return None, None
        elif workspace_id == "Scratchpad":
            return commands["assign_workspace"][0], None
        else:
            return commands["assign_workspace"][1].format(str(workspace_id.replace("Workspace", "").strip())), commands["assign_workspace"][1].format("").strip()
    else:
        return None, None

def write_to_config(wm_class, wm_instance, wm_type, arg):
    with open("/home/cliffniff/.config/i3/config", "r+") as f:
        ref_id = flags[arg]
        general_matcher = "for_window[class={0} instance={1} window_type={2}]".format(wm_class, wm_instance, wm_type)
        config_lines = f.readlines()
        modified = False

        rule_props, stripped_command = get_rule_props(ref_id)
        if stripped_command is None:
            stripped_command = rule_props
        if rule_props == None:
            exit(0)
        for p_index, config_line in enumerate(config_lines):
            if general_matcher in config_line:
                print("Rules for window already exist")
                config_line_props = config_line.replace(general_matcher, "").strip().split(",")
                for index, config_line_prop in enumerate(config_line_props):
                    config_line_prop = config_line_prop.strip()
                    if stripped_command in config_line_prop:
                        print("Intended rules already exists, overwriting...")
                        config_line_props[index] = rule_props
                        modified = True
                        break
                if not modified:
                    config_line_props.append(rule_props)
                print("New rules: ", config_line_props)
                config_lines[p_index] = general_matcher + " " + ",".join(config_line_props) + "\n"
                modified = True
                break
        print(general_matcher)
        if not modified:
            config_lines.append(general_matcher + " " + rule_props + "\n")
        f.seek(0)
        f.write("".join(config_lines))


def main():
    sleep(0.2)
    wm_class, wm_instance, wm_type = get_props()
    if type(wm_class) != str:
        exit_f(1, "Error: {0}".format(wm_class))
    else:
        if len(argv) > 1:
            possible_args = flags.keys()
            for arg in argv:
                if arg in possible_args:
                    print("Arg found " + arg)
                    write_to_config(wm_class, wm_instance, wm_type, arg)
                    exit_f(0)
        exit_f(1, "Error: Invalid arguments")

if __name__ == "__main__":
    main()