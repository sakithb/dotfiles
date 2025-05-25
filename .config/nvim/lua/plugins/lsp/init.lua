local M = {}

local servers = require("plugins.lsp.servers")
local capabilities = vim.lsp.protocol.make_client_capabilities()

M[1] = {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        {
            "neovim/nvim-lspconfig",
            lazy = false,
            dependencies = {
                "hrsh7th/cmp-nvim-lsp"
            },
            init = function ()
                capabilities = vim.tbl_deep_extend(
                    "force",
                    capabilities,
                    require("cmp_nvim_lsp").default_capabilities()
                )
            end,
            config = function ()
                require("lspconfig").ols.setup({})
            end
        },
        {
            "williamboman/mason.nvim",
            lazy = false,
            config = true
        }
    },
    opts = {
        handlers = {
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                })
            end,
        }
    },
}

return M
