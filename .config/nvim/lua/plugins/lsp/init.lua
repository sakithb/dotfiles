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

M[2] = {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim",
    },
    config = function()
        require("mason").setup()

        local null_ls = require("null-ls")
        null_ls.setup({})

        require("mason-null-ls").setup({
            ensure_installed = { "stylua", "eslint_d" },
            automatic_installation = true,
            handlers = {},
        })
    end
}

return M
