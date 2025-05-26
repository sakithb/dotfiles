local keymaps = require("core.keymaps")

local editing_grp = vim.api.nvim_create_augroup("editing", {})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = editing_grp,
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = editing_grp,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local settings = client.config.settings

        if settings and settings.editor then
            if settings.editor.tabSize ~= nil then
                vim.api.nvim_buf_set_option(args.buf, "tabstop", settings.editor.tabSize)
            end

            if settings.editor.insertSpaces ~= nil then
                vim.api.nvim_buf_set_option(args.buf, "expandtab", settings.editor.insertSpaces)
            end
        end
    end,
})

local lsp_grp = vim.api.nvim_create_augroup("lsp", {});

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_grp,
    callback = keymaps.setupLspKeymaps
})
