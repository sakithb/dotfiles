return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "debugloop/telescope-undo.nvim",
            "nvim-web-devicons",
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build =
                'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            }
        },
        config = function()
            local telescope = require("telescope")

            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")
            local actions_layout = require("telescope.actions.layout")

            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<M-p>"] = actions_layout.toggle_preview,
                            ["<M-s>"] = actions.toggle_all,
                            ["<esc>"] = actions.close,
                            ["<C-k>"] = actions.cycle_history_next,
                            ["<C-j>"] = actions.cycle_history_prev,
                        },
                    },
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
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                    buffers = {
                        theme = "dropdown",
                        previewer = false,
                        ignore_current_buffer = true,
                        sort_mru = true,
                        mappings = {
                            i = {
                                ["<M-d>"] = actions.delete_buffer,
                            },
                        },
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
            })

            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find git files" })
            vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })

            vim.keymap.set("n", "<leader>ss", builtin.live_grep, { desc = "Search across files" })
            vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search word" })
            vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search help" })
            vim.keymap.set("n", "<leader>sb", builtin.current_buffer_fuzzy_find, { desc = "Search in buffer" })

            vim.keymap.set("n", "<leader><CR>", builtin.buffers, { desc = "List open buffers" })
            vim.keymap.set("n", "<leader>lq", builtin.quickfix, { desc = "List quickfix items" })
            vim.keymap.set("n", "<leader>lm", builtin.marks, { desc = "List marks" })
            vim.keymap.set("n", "<leader>lj", builtin.jumplist, { desc = "List jumplist" })
            vim.keymap.set("n", "<leader>lr", builtin.registers, { desc = "List registers" })
            vim.keymap.set("n", "<leader>lk", builtin.keymaps, { desc = "List keymaps" })

            vim.keymap.set("n", "<leader>gls", builtin.lsp_document_symbols, { desc = "List document symbols" })
            vim.keymap.set("n", "<leader>glw", builtin.lsp_workspace_symbols, { desc = "List workspace symbols" })
            vim.keymap.set("n", "<leader>glr", builtin.lsp_references, { desc = "List references" })
            vim.keymap.set("n", "<leader>gld", builtin.diagnostics, { desc = "List diagnostics" })

            vim.keymap.set("n", "<leader>gtc", builtin.git_commits, { desc = "List git commits" })
            vim.keymap.set("n", "<leader>gtm", builtin.git_bcommits, { desc = "List git buffer commits" })
            vim.keymap.set("n", "<leader>gts", builtin.git_status, { desc = "Show git status" })
            vim.keymap.set("n", "<leader>gth", builtin.git_stash, { desc = "List git stash" })
            vim.keymap.set("n", "<leader>gtb", builtin.git_branches, { desc = "List git branches" })

            telescope.load_extension("file_browser")
            telescope.load_extension("ui-select")
            telescope.load_extension("undo")

            vim.keymap.set("n", "<leader>u", telescope.extensions.undo.undo, {})
            vim.keymap.set("n", "<leader>fb", telescope.extensions.file_browser.file_browser, {})
        end,
    },
}
