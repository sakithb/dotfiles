vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("")
	end,
})

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "nvimdev/dashboard-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VimEnter",
        config = function ()
            require("dashboard").setup({
                theme = "hyper",
                config = {
                    shortcut = {
                        { desc = 'solo', group = 'projects', action = 'Telescope file_browser path=/home/sakithb/Projects/solo', key = 's' },
                        { desc = 'play', group = 'projects', action = 'Telescope file_browser path=/home/sakithb/Projects/play', key = 'p' },
                        { desc = 'clones', group = 'projects', action = 'Telescope file_browser path=/home/sakithb/Projects/clones', key = 'c' },
                        { desc = 'work', group = 'projects', action = 'Telescope file_browser path=/home/sakithb/Projects/work', key = 'w' },
                        { desc = 'scripts', group = 'projects', action = 'Telescope file_browser path=/home/sakithb/Projects/scripts', key = 'r' },
                    },
                    footer = {}
                }
            })

            vim.cmd("Dashboard")
        end
    },
}
