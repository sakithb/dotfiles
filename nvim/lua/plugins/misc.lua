return {
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"coffebar/neovim-project",
		lazy = false,
		priority = 100,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
			{ "Shatur/neovim-session-manager" },
		},
		config = function()
			require("neovim-project").setup({
				projects = {
					"~/Projects/*/*",
				},
			})

			vim.keymap.set("n", "<leader>pa", ":Telescope neovim-project discover<CR>")
			vim.keymap.set("n", "<leader>pr", ":Telescope neovim-project history<CR>")

			if vim.fn.argc() == 0 then
				vim.defer_fn(function()
					vim.cmd(":Telescope neovim-project discover")
				end, 0)
			else
				vim.cmd("cd " .. vim.fn.argv()[1])
			end
		end,
	},
}
