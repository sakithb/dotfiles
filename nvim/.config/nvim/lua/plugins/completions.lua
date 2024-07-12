return {
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	dependencies = {
	-- 		"AndreM222/copilot-lualine",
	-- 		"zbirenbaum/copilot-cmp",
	-- 	},
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("copilot_cmp").setup({})
	-- 		require("copilot").setup({
	-- 			suggestion = { enabled = false },
	-- 			panel = { enabled = false },
	-- 		})
	-- 	end,
	-- },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
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
					-- { name = "copilot", group_index = 1 },
					{ name = "luasnip",  group_index = 1 },
					{ name = "buffer",   group_index = 2 },
				}),
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-Esc>"] = cmp.mapping.abort(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
				}),
				window = {
					documentation = cmp.config.window.bordered(),
					completion = cmp.config.window.bordered({
						winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
					}),
				},
			})
		end,
	},
}
