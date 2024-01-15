return {
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").load()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "onedark",
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
