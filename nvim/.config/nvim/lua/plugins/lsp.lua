return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason-lspconfig").setup()
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    local server_config = {
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    }

                    if server_name == "lua_ls" then
                        server_config = vim.tbl_extend("force", server_config, {
                            settings = {
                                Lua = {
                                    runtime = {
                                        version = "LuaJIT",
                                    },
                                    diagnostics = {
                                        globals = { "vim" },
                                    },
                                    workspace = {
                                        library = { vim.env.VIMRUNTIME },
                                        checkThirdParty = false,
                                    },
                                },
                            },
                        })
                    end

                    require("lspconfig")[server_name].setup(server_config)
                end,
            })
        end,
    },
}
