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
                },
                enrich_config = function(config, on_config)
                    local c = vim.deepcopy(config)
                    c.cwd = vim.fn.fnamemodify(c.program, ":p:h")
                    on_config(c)
                end
            },
            gdb = {
                type = "executable",
                command = "gdb",
                args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
                name = "gdb",
                options = {
                    initialize_timeout_sec =  60,
                    disconnect_timeout_sec =  60,
                },
                enrich_config = function(config, on_config)
                    local c = vim.deepcopy(config)
                    c.cwd = vim.fn.fnamemodify(c.program, ":p:h")
                    on_config(c)
                end
            },
            debugpy = function(cb, config)
                if config.request == "attach" then
                    local port = (config.connect or config).port
                    local host = (config.connect or config).host or "127.0.0.1"
                    cb({
                        type = "server",
                        port = assert(port, "`connect.port` is required for a python `attach` configuration"),
                        host = host,
                        options = {
                            source_filetype = "python",
                        },
                    })
                else
                    cb({
                        type = "executable",
                        command = "/home/sakithb/Projects/other/debugpy/bin/python",
                        args = { "-m", "debugpy.adapter" },
                        options = {
                            source_filetype = "python",
                        },
                    })
                end
            end
        }

        local g_ll_db = {
            {
                name = "Launch (LLDB)",
                type = "lldb",
                request = "launch",
                program = utils.pick_file,
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
            {
                name = "Attach (LLDB)",
                type = "lldb",
                request = "attach",
                pid = utils.pick_process,
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
            {
                name = "Launch (GDB)",
                type = "gdb",
                request = "launch",
                program = utils.pick_file,
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
            {
                name = "Attach (GDB)",
                type = "gdb",
                request = "attach",
                pid = utils.pick_process,
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
        }

        dap.configurations = {
            c = g_ll_db,
            cpp = g_ll_db,
            odin = g_ll_db,
            python = {
                {
                    type = "debugpy",
                    request = "launch",
                    name = "Launch",

                    program = function() return utils.pick_file({ filter = ".*%.py", executables = false }) end,
                    pythonPath = function()
                        local cwd = vim.fn.getcwd()
                        if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                            return cwd .. "/.venv/bin/python"
                        else
                            return "/usr/bin/python"
                        end
                    end;
                },
            }
        }

        keymaps.setupDapKeymaps()
    end
}

return M
