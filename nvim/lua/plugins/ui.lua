return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "tokyonight",
					component_separators = " ",
				},
				sections = {
					lualine_x = {
						{
							"copilot",
							symbols = {
								spinners = require("copilot-lualine.spinners").pipe,
							},
						},
						"filetype",
					},
					lualine_y = { "searchcount", "selectioncount", "tabs" },
				},
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			progress = {
				suppress_on_insert = false,
				ignore_done_already = false,
				ignore_empty_message = false,
			},
		},
	},
}
