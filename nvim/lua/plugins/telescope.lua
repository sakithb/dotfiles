return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-web-devicons",
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})

			vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, {})

			vim.keymap.set("n", "<leader>gtc", builtin.git_commits, {})
			vim.keymap.set("n", "<leader>gts", builtin.git_status, {})
			vim.keymap.set("n", "<leader>gth", builtin.git_stash, {})

			telescope.load_extension("file_browser")
			telescope.load_extension("ui-select")
			vim.keymap.set("n", "<C-n>", telescope.extensions.file_browser.file_browser, {})
		end,
	},
}
