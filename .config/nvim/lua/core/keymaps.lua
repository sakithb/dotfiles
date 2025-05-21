local M = {}

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Goto next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Goto previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdel<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>ba", ":enew<CR>", { desc = "Edit new buffer" })
vim.keymap.set("n", "<leader>bb", ":e#<CR>", { desc = "Switch to last buffer" })

vim.keymap.set("n", "<leader>ps", ":split<CR>", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>pv", ":vsplit<CR>", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>ph", "<C-w>h", { desc = "Move to the pane in the left" })
vim.keymap.set("n", "<leader>pj", "<C-w>j", { desc = "Move to the pane below" })
vim.keymap.set("n", "<leader>pk", "<C-w>k", { desc = "Move to the pane above" })
vim.keymap.set("n", "<leader>pl", "<C-w>l", { desc = "Move to the pane in the right" })
vim.keymap.set("n", "<leader>pd", ":close<CR>", { desc = "Close pane" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

vim.keymap.set("n", "<leader>rr", ":%s///gc<left><left><left><left>", { desc = "Replace in file" })
vim.keymap.set("v", "<leader>rr", ":s///gc<left><left><left><left>", { desc = "Replace in selection" })

vim.keymap.set({ "n", "v" }, "<M-y>", "\"+y", { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<M-p>", "\"+p", { desc = "Paste to system clipboard" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Discard search highlights:" })

function M.setupLspKeymaps(ev)
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename symbol" })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { buffer = ev.buf, desc = "Format" })
    vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "List code actions" })
    vim.keymap.set("n", "<leader>gc", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Goto declaration" })
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Goto definition" })
    vim.keymap.set("n", "<leader>gy", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Goto type definition" })
    vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Goto implementation" })

    vim.keymap.set("n", "<S-k>", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Show documentation" })
    vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Show signature help" })
    vim.keymap.set({ "n", "i" }, "<M-k>", vim.diagnostic.open_float, { buffer = ev.buf, desc = "Show diagnostics in the line" })

    vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev, { buffer = ev.buf, desc = "Goto previous diagnostic" })
    vim.keymap.set("n", "<leader>gn", vim.diagnostic.goto_next, { buffer = ev.buf, desc = "Goto next diagnostic" })
end

function M.setupTelescopeKeymaps()
    local extensions = require("telescope").extensions
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find git files" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })
    vim.keymap.set("n", "<leader>fb", extensions.file_browser.file_browser, {})

    vim.keymap.set("n", "<leader>ss", builtin.live_grep, { desc = "Search across files" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search word" })
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search help" })
    vim.keymap.set("n", "<leader>sb", builtin.current_buffer_fuzzy_find, { desc = "Search in buffer" })

    vim.keymap.set("n", "<leader><CR>", builtin.buffers, { desc = "List open buffers" })
    vim.keymap.set("n", "<leader>lq", builtin.quickfix, { desc = "List quickfix items" })
    vim.keymap.set("n", "<leader>lm", builtin.marks, { desc = "List marks" })
    vim.keymap.set("n", "<leader>lj", builtin.jumplist, { desc = "List jumplist" })
    vim.keymap.set("n", "<leader>lr", builtin.registers, { desc = "List registers" })
    vim.keymap.set("n", "<leader>lk", builtin.keymaps, { desc = "List keymaps" })

    vim.keymap.set("n", "<leader>gls", builtin.lsp_document_symbols, { desc = "List document symbols" })
    vim.keymap.set("n", "<leader>glw", builtin.lsp_workspace_symbols, { desc = "List workspace symbols" })
    vim.keymap.set("n", "<leader>glr", builtin.lsp_references, { desc = "List references" })
    vim.keymap.set("n", "<leader>gld", builtin.diagnostics, { desc = "List diagnostics" })

    vim.keymap.set("n", "<leader>gtc", builtin.git_commits, { desc = "List git commits" })
    vim.keymap.set("n", "<leader>gtm", builtin.git_bcommits, { desc = "List git buffer commits" })
    vim.keymap.set("n", "<leader>gts", builtin.git_status, { desc = "Show git status" })
    vim.keymap.set("n", "<leader>gth", builtin.git_stash, { desc = "List git stash" })
    vim.keymap.set("n", "<leader>gtb", builtin.git_branches, { desc = "List git branches" })

    vim.keymap.set("n", "<leader>u", extensions.undo.undo, {})
end

function M.setupTelescopeMappings(opts)
    local actions = require("telescope.actions")
    local actions_layout = require("telescope.actions.layout")

    opts.defaults.mappings = {
        i = {
            ["<M-p>"] = actions_layout.toggle_preview,
            ["<M-s>"] = actions.toggle_all,
            ["<esc>"] = actions.close,
            ["<C-k>"] = actions.cycle_history_next,
            ["<C-j>"] = actions.cycle_history_prev,
        },
    }

    opts.pickers.buffers.mappings = {
        i = {
            ["<M-d>"] = actions.delete_buffer,
        },
    }
end

function M.getCmpMappings()
    local cmp = require("cmp")
    return cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
    })
end

function M.setupDapKeymaps()
    local dap = require("dap")
    local widgets = require("dap.ui.widgets")

    local function logpoint()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log: "))
    end

    local function frames()
        widgets.centered_float(widgets.frames)
    end

    local function scopes()
        widgets.centered_float(widgets.scopes)
    end

    local function threads()
        widgets.centered_float(widgets.threads)
    end

    local function expression()
        widgets.cursor_float(widgets.expression)
    end

    vim.keymap.set("n", "<leader>dd", dap.continue, { desc = "Debug: continue or start session" })
    vim.keymap.set("n", "<leader>ddr", dap.restart, { desc = "Debug: restart session" })
    vim.keymap.set("n", "<leader>ddp", dap.pause, { desc = "Debug: pause session" })
    vim.keymap.set("n", "<leader>ddl", dap.run_last, { desc = "Debug: start last session" })
    vim.keymap.set("n", "<leader>ddt", dap.terminate, { desc = "Debug: terminate session" })

    vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Debug: open repl" })
    vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { desc = "Debug: run to cursor" })

    vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Debug: step over" })
    vim.keymap.set("n", "<leader>dni", dap.step_into, { desc = "Debug: step into" })
    vim.keymap.set("n", "<leader>dno", dap.step_out, { desc = "Debug: step out" })

    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: toggle breakpoint" })
    vim.keymap.set("n", "<leader>dbl", logpoint, { desc = "Debug: set logpoint" })
    vim.keymap.set("n", "<leader>dbs", dap.list_breakpoints, { desc = "Debug: list breakpoints" })
    vim.keymap.set("n", "<leader>dbc", dap.clear_breakpoints, { desc = "Debug: clear breakpoints" })


    vim.keymap.set({"n", "v"}, "<C-S-k>", widgets.hover, { desc = "Debug: show expression" })
    vim.keymap.set("n", "<leader>df", frames, { desc = "Debug: show stackframes" })
    vim.keymap.set("n", "<leader>dfu", dap.up, { desc = "Debug: goto frame above" })
    vim.keymap.set("n", "<leader>dfd", dap.down, { desc = "Debug: goto frame below" })
    vim.keymap.set("n", "<leader>dff", dap.down, { desc = "Debug: focus current frame" })
    vim.keymap.set("n", "<leader>ds", scopes, { desc = "Debug: show scopes" })
    vim.keymap.set("n", "<leader>de", expression, { desc = "Debug: show expression" })
    vim.keymap.set("n", "<leader>dt", threads, { desc = "Debug: show threads" })
end

return M
