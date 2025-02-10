local M = {}

local keymaps = require("core.keymaps")

M[1] = {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-web-devicons",
		{
			"nvim-telescope/telescope-file-browser.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			}
		},
        {
	        "nvim-telescope/telescope-ui-select.nvim",
            dependencies = {
				"nvim-lua/plenary.nvim",
			},
		},
		{
			"debugloop/telescope-undo.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
		}
	},
	opts = {
		defaults = {
			file_ignore_patterns = { ".git/" },
		},
		extensions = {
			file_browser = {
				layout_strategy = "vertical",
				previewer = false,
				path = "%:p:h",
				select_buffer = true,
				hijack_netrw = true,
				no_ignore = true,
				cwd_to_path = true,
				hidden = true,
                grouped = true,
			},
		},
		pickers = {
			find_files = {
				hidden = true,
			},
			git_files = {
				show_untracked = true,
			},
			buffers = {
				theme = "dropdown",
				previewer = false,
				ignore_current_buffer = true,
				sort_mru = true,
			},
			oldfiles = {
				theme = "dropdown",
				previewer = false,
			},
			registers = {
				theme = "dropdown",
				previewer = false,
			},
			kemaps = {
				theme = "dropdown",
				previewer = false,
			},
			git_branches = {
				theme = "dropdown",
				previewer = false,
			},
		},
	},
	config = function(_, opts)
		keymaps.setupTelescopeKeymaps()
		keymaps.setupTelescopeMappings(opts)

		local telescope = require("telescope")
		telescope.setup(opts)

		telescope.load_extension("file_browser")
        telescope.load_extension("ui-select")
		telescope.load_extension("undo")
	end
}

return M
