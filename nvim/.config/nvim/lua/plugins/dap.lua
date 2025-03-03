local M = {}

local keymaps = require("core.keymaps")

M[1] = {
    "mfussenegger/nvim-dap",
    config = function()
        local dap = require("dap")
        local utils = require("dap.utils")

        dap.adapters = {
            lldb = {
                type = "executable",
                command = "lldb-dap-18",
                name = "lldb",
                options = {
                    initialize_timeout_sec =  60,
                    disconnect_timeout_sec =  60,
                }
            },
            gdb = {
                type = "executable",
                command = "gdb",
                args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
                name = "gdb",
                options = {
                    initialize_timeout_sec =  60,
                    disconnect_timeout_sec =  60,
                }
            }
        }

        local g_ll_db = {
            {
                name = "Launch (LLDB)",
                type = "lldb",
                request = "launch",
                program = utils.pick_file,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
            {
                name = "Attach (LLDB)",
                type = "lldb",
                request = "attach",
                pid = utils.pick_process,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
            {
                name = "Launch (GDB)",
                type = "gdb",
                request = "launch",
                program = utils.pick_file,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
            {
                name = "Attach (GDB)",
                type = "gdb",
                request = "attach",
                pid = utils.pick_process,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
        }

        dap.configurations = {
            c = g_ll_db,
            cpp = g_ll_db,
            odin = g_ll_db,
        }

        keymaps.setupDapKeymaps()
    end
}

return M
