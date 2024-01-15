return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter-context",
		opts = {
			max_lines = 5,
		},
	},
}
