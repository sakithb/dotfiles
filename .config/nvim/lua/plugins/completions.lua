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
                { name = "nvim_lsp", group_index = 1 },
                { name = 'luasnip',  group_index = 1 },
                { name = "buffer",   group_index = 2 },
            }),
            mapping = keymaps.getCmpMappings(),
            completion = { autocomplete = false },
            window = {
                documentation = cmp.config.window.bordered({
                    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                }),
                completion = cmp.config.window.bordered({
                    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                }),
            },
            formatting = {
                format = function(_, vim_item)
                    local abbr = vim_item.abbr
                    vim_item.abbr = vim.fn.strcharpart(abbr, 0, 40)
                    if abbr ~= vim_item.abbr then
                        vim_item.abbr = vim_item.abbr .. "…"
                    end

                    if vim_item.menu then
                        local menu = vim_item.menu
                        vim_item.menu = vim.fn.strcharpart(menu, 0, 20)
                        if menu ~= vim_item.menu then
                            vim_item.menu = vim_item.menu .. "…"
                        end
                    end

                    return vim_item
                end
            }
        })
    end,
}

return M
