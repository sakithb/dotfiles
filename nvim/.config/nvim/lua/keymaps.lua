vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Custom functions

local function goto_last_terminal()
    local bufnrs = vim.api.nvim_list_bufs()

    table.sort(bufnrs, function(a, b)
        return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
    end)

    for i = 1, #bufnrs do
        if vim.api.nvim_buf_is_valid(bufnrs[i]) and string.match(vim.api.nvim_buf_get_name(bufnrs[i]), "^term://") then
            vim.api.nvim_set_current_buf(bufnrs[i])
            break
        end
    end
end

-- Keymaps

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", {})
vim.keymap.set("n", "<leader>bp", ":bprev<CR>", {})
vim.keymap.set("n", "<leader>bd", ":bd<CR>", {})
vim.keymap.set("n", "<leader>bw", ":bw<CR>", {})
vim.keymap.set("n", "<leader>br", ":e#<CR>", {})

vim.keymap.set("n", "<leader>bf", ":bf<CR>", {})
vim.keymap.set("n", "<leader>b1", ":b1<CR>", {})
vim.keymap.set("n", "<leader>b2", ":b2<CR>", {})
vim.keymap.set("n", "<leader>b3", ":b3<CR>", {})
vim.keymap.set("n", "<leader>b4", ":b4<CR>", {})
vim.keymap.set("n", "<leader>b5", ":b5<CR>", {})
vim.keymap.set("n", "<leader>b6", ":b6<CR>", {})
vim.keymap.set("n", "<leader>b7", ":b7<CR>", {})
vim.keymap.set("n", "<leader>b8", ":b8<CR>", {})
vim.keymap.set("n", "<leader>b9", ":b9<CR>", {})
vim.keymap.set("n", "<leader>bl", ":bl<CR>", {})
vim.keymap.set("n", "<leader>bb", ":b#<CR>", {})
vim.keymap.set("n", "<leader>bt", goto_last_terminal, {})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>t", ":terminal<CR>", {})
vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], {})

vim.keymap.set("n", "<leader>rr", ":%s///gc<left><left><left><left>", {})
vim.keymap.set("v", "<leader>rr", ":s///gc<left><left><left><left>", {})

vim.keymap.set({ "n", "v" }, "<M-y>", '"+y', {})
vim.keymap.set({ "n", "v" }, "<M-p>", '"+p', {})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Autocommands

local TerminalAuGrp = vim.api.nvim_create_augroup("Terminal", {})

vim.api.nvim_create_autocmd("TermOpen", {
    group = TerminalAuGrp,
    callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.cmd("startinsert!")
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = TerminalAuGrp,
    pattern = "term://*",
    callback = function()
        vim.cmd("startinsert!")
    end,
})

local EditingAuGrp = vim.api.nvim_create_augroup("Editing", {})

vim.api.nvim_create_autocmd('TextYankPost', {
    group = EditingAuGrp,
    callback = function()
        vim.highlight.on_yank()
    end,
})

local LspAuGRP = vim.api.nvim_create_augroup("LspConfig", {});

vim.api.nvim_create_autocmd("LspAttach", {
    group = LspAuGRP,
    callback = function(ev)
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename symbol" })
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { buffer = ev.buf, desc = "Format" })
        vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "List code actions" })
        vim.keymap.set("n", "<leader>gl", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Goto declaration" })
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Goto definition" })
        vim.keymap.set("n", "<leader>gy", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Goto type definition" })
        vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Goto implementation" })

        vim.keymap.set("n", "<S-k>", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Show documentation" })
        vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Show signature help" })
        vim.keymap.set({ "n", "i" }, "<M-k>", vim.diagnostic.open_float, { buffer = ev.buf, desc = "Show diagnostics in the line" })
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = ev.buf, desc = "Goto previous diagnostic" })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = ev.buf, desc = "Goto next diagnostic" })
    end,
})
