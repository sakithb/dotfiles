local M = {}

M[1] = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			auto_install = true,
			highlight = {
				enable = true,
				disable = function(_, buf)
					local max_filesize = 100 * 1024
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gsi",
					node_incremental = "gsn",
					scope_incremental = "gss",
					node_decremental = "gsp",
				},
			},
		})
	end
}

M[2] = {
	"nvim-treesitter/nvim-treesitter-context",
	opts = {
		max_lines = 8,
	}
}

return M
