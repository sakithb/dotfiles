local M = {}

M[1] = {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    init = function()
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
            component_separators = " ",
            section_separators = " "
        },
        sections = {
            lualine_x = { "filetype" },
            lualine_y = { "searchcount", "selectioncount", "tabs" }
        }
    }
}

return M
