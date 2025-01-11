local M = {}

local keymaps = require("core.keymaps")

M[1] = {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
    end
}

M[2] = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        {
            "saadparwaiz1/cmp_luasnip",
            dependencies = { "L3MON4D3/LuaSnip" },
        }
    },
    config = function()
        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            sources = cmp.config.sources({
                { name = "path",     group_index = 1 },
                { name = 'luasnip',  group_index = 1 },
                { name = "nvim_lsp", group_index = 1 },
                { name = "buffer",   group_index = 2 },
            }),
            mapping = keymaps.getCmpMappings(),
            completion = { autocomplete = false },
            window = {
                documentation = cmp.config.window.bordered(),
                completion = cmp.config.window.bordered({
                    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                }),
            },
        })
    end,
}

return M
