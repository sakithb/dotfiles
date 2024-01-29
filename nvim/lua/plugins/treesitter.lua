return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				max_lines = 5,
				mode = "cursor",
			})

			vim.keymap.set("n", "<leader>gc", function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end, { silent = true })
		end,
	},
}
