return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
	  'rmagatti/auto-session',
	  lazy = false,
	  dependencies = {
		'nvim-telescope/telescope.nvim',
	  },
	  keys = {
		  { '<leader>wr', '<cmd>SessionSearch<CR>', desc = 'Session search' },
		  { '<leader>ws', '<cmd>SessionSave<CR>', desc = 'Save session' },
		  { '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
	  },
	  opts = {
		auto_session_allowed_dirs = {
			"~/Projects/personal/*",
			"~/Projects/work/*",
			"~/Projects/temp/*"
		},
	  }
	}
	-- {
	-- 	"coffebar/neovim-project",
	-- 	lazy = false,
	-- 	priority = 100,
	-- 	dependencies = {
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 		{ "nvim-telescope/telescope.nvim" },
	-- 		{ "Shatur/neovim-session-manager" },
	-- 	},
	-- 	config = function()
	-- 		require("neovim-project").setup({
	-- 			projects = {
	-- 				"~/Projects/*/*",
	-- 			},
	-- 		})

	-- 		vim.keymap.set("n", "<leader>pp", ":Telescope neovim-project discover<CR>")
	-- 		vim.keymap.set("n", "<leader>pr", ":Telescope neovim-project history<CR>")

	-- 		if vim.fn.argc() == 0 and vim.fn.expand("%") == vim.loop.cwd() then
	-- 			vim.defer_fn(function()
	-- 				vim.cmd(":Telescope neovim-project discover")
	-- 			end, 0)
	-- 		else
	-- 			vim.cmd("cd " .. vim.fn.expand("%:p:h"))
	-- 		end
	-- 	end,
	-- },
}
