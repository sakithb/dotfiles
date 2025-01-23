local wezterm = require("wezterm")
local mux = wezterm.mux
local action = wezterm.action

local config = wezterm.config_builder()

local last_workspace = "default"

-- Options

config.default_prog = { "bash" }
config.default_cwd = "\\\\wsl.localhost\\Arch\\home\\sakithb"
config.color_scheme = "Gruvbox dark, medium (base16)"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 13.5

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.disable_default_key_bindings = true
config.show_new_tab_button_in_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.unix_domains = {
    {
        name = "unix",
    },
}

config.default_gui_startup_args = { 'connect', 'unix' }

-- Keymaps

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
    {
        key = "b",
        mods = "LEADER|CTRL",
        action = action.SendKey({ key = "b", mods = "CTRL" }),
    },
    {   
        key = "x",
        mods = "LEADER", 
        action = wezterm.action.ActivateCopyMode 
    },
    {
        key = "c",
        mods = "LEADER",
        action = wezterm.action_callback(function(window, pane)
            window:perform_action(
                action.SpawnCommandInNewTab({ cwd = "\\" .. pane:get_current_working_dir().file_path }),
                pane
            )
        end)
    },
    {
        key = "n",
        mods = "LEADER",
        action = action.ActivateTabRelative(1),
    },
    {
        key = "p",
        mods = "LEADER",
        action = action.ActivateTabRelative(-1),
    },
    {
        key = "b",
        mods = "LEADER",
        action = action.ActivateLastTab,
    },
    {
        key = "h",
        mods = "LEADER",
        action = action.ActivatePaneDirection("Left"),
    },
    {
        key = "l",
        mods = "LEADER",
        action = action.ActivatePaneDirection("Right"),
    },
    {
        key = "k",
        mods = "LEADER",
        action = action.ActivatePaneDirection("Up"),
    },
    {
        key = "j",
        mods = "LEADER",
        action = action.ActivatePaneDirection("Down"),
    },
    {
        key = "q",
        mods = "LEADER",
        action = action.CloseCurrentPane({ confirm = false }),
    },
    {
        key = "s",
        mods = "LEADER",
        action = wezterm.action_callback(function (window, pane)
            local w = last_workspace
            last_workspace = window:active_workspace()
            window:perform_action(
                action.SwitchToWorkspace({
                    name = w
                }),
                pane
            )
        end)
    },
    {
        key = "|",
        mods = "LEADER|SHIFT",
        action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "_",
        mods = "LEADER|SHIFT",
        action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "C",
        mods = "CTRL|SHIFT",
        action = action.CopyTo("Clipboard")
    },
    {
        key = "V",
        mods = "CTRL|SHIFT",
        action = action.PasteFrom("Clipboard")
    },
    {
        key = "L",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ShowDebugOverlay
    },
    {
        key = 'D',
        mods = 'CTRL|SHIFT',
        action = action.DetachDomain("CurrentPaneDomain"),
    },
    {
        key = "w",
        mods = "LEADER",
        action = wezterm.action_callback(function(window, pane)
            local dirs = {
                "\\\\wsl.localhost\\Arch\\home\\sakithb\\Projects\\personal",
                "\\\\wsl.localhost\\Arch\\home\\sakithb\\Projects\\work",
                "\\\\wsl.localhost\\Arch\\home\\sakithb\\Projects\\temp",
            }

            local choices = {
                {
                    id = "default",
                    label = "default"
                },
                {
                    id = "\\\\wsl.localhost\\Arch\\home\\sakithb\\Projects\\scripts",
                    label = "scripts"
                }
            }

            for _, dir in pairs(dirs) do
                for _, entry in ipairs(wezterm.read_dir(dir)) do
                    table.insert(choices, {
                        id = entry,
                        label = string.gsub(entry, "(.*\\)(.*)", "%2")
                    })
                end
            end

            local ws_names = {}
            for _, ws_name in ipairs(mux.get_workspace_names()) do
                ws_names[ws_name] = true
            end

            table.sort(choices, function(a, b)
                if (a.id == "default") then return true end
                if (b.id == "default") then return false end

                local a_exists = ws_names[a.label] ~= nil
                local b_exists = ws_names[b.label] ~= nil

                return
                    (a_exists and not b_exists) or
                    (a_exists and b_exists)
            end)

            for _, choice in ipairs(choices) do
                if ws_names[choice.label] then
                    choice.label = wezterm.format({
                        { Foreground = { AnsiColor = "Green" } },
                        { Text = choice.label }
                    })
                end
            end

            window:perform_action(
                action.InputSelector({
                    title = "Select workspace",
                    fuzzy_description = "Filter workspace: ",
                    choices = choices,
                    fuzzy = true,
                    action = wezterm.action_callback(function(_, _, entry, label)
                        if entry ~= nil then
                            label = label:gsub("\x1b%[%d+;%d+;%d+;%d+;%d+m","")
                                :gsub("\x1b%[%d+;%d+;%d+;%d+m","")
                                :gsub("\x1b%[%d+;%d+;%d+m","")
                                :gsub("\x1b%[%d+;%d+m","")
                                :gsub("\x1b%[%d+m","")

                            window:perform_action(
                                action.SwitchToWorkspace({
                                    name = label,
                                    spawn = {
                                        cwd = (entry == "default" and config.default_cwd) or entry
                                    }
                                }),
                                pane
                            )
                        end
                    end)
                }),
                pane
            )
        end)
    }
}

for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = action.ActivateTab(i - 1),
    })
end

-- Events

wezterm.on("gui-attached", function(domain)
    local workspace = mux.get_active_workspace()
    for _, window in ipairs(mux.all_windows()) do
        if window:get_workspace() == workspace then
            window:gui_window():maximize()
        end
    end
end)

wezterm.on("update-right-status", function(window, pane)
      window:set_right_status(wezterm.format({
          { Background = { Color = "black" } },
          { Foreground = { Color = "white" } },
          { Text = " " .. window:active_workspace() .. " " }
      }))
end)

return config
