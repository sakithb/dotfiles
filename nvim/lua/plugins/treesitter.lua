return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end
    },
    {
        "nvim-treesitter-context",
        opts = {
            mode = "cursor",
            max_lines = 3,
        }
    }
}
