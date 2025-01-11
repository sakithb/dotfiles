local M = {}

M[1] = {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
        invert_tabline = true
    },
    config = function(opts)
        require("gruvbox").setup(opts)
        vim.cmd.colorscheme("gruvbox")
    end,
    config = true
}

M[2] = {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
        auto_session_allowed_dirs = {
            "~/Projects/personal/*",
            "~/Projects/work/*",
            "~/Projects/temp/*"
        },
    }
}

M[3] = {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    opts = {
        options = {
            theme = "gruvbox_dark",
            component_separators = " ",
            section_separators = " "
        },
        sections = {
            lualine_b = { "branch", "diagnostics" },
            lualine_x = { "filetype" },
            lualine_y = { "diff" },
            lualine_z = { "searchcount", "selectioncount", "location" }
        }
    }
}

return M
