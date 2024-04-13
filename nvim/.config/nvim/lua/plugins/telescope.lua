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

            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
            vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})

            vim.keymap.set("n", "<leader>ss", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>sw", builtin.grep_string, {})
            vim.keymap.set("n", "<leader>sh", builtin.help_tags, {})
            vim.keymap.set("n", "<leader>sb", builtin.current_buffer_fuzzy_find, {})

            vim.keymap.set("n", "<leader><CR>", builtin.buffers, {})
            vim.keymap.set("n", "<leader>lq", builtin.quickfix, {})
            vim.keymap.set("n", "<leader>lm", builtin.marks, {})
            vim.keymap.set("n", "<leader>lj", builtin.jumplist, {})
            vim.keymap.set("n", "<leader>lr", builtin.registers, {})
            vim.keymap.set("n", "<leader>lk", builtin.keymaps, {})

            vim.keymap.set("n", "<leader>gls", builtin.lsp_document_symbols, {})
            vim.keymap.set("n", "<leader>glw", builtin.lsp_workspace_symbols, {})
            vim.keymap.set("n", "<leader>glr", builtin.lsp_references, {})
            vim.keymap.set("n", "<leader>gld", builtin.diagnostics, {})

            vim.keymap.set("n", "<leader>gtc", builtin.git_commits, {})
            vim.keymap.set("n", "<leader>gts", builtin.git_status, {})
            vim.keymap.set("n", "<leader>gth", builtin.git_stash, {})
            vim.keymap.set("n", "<leader>gtb", builtin.git_branches, {})

            telescope.load_extension("file_browser")
            telescope.load_extension("ui-select")
            telescope.load_extension("undo")

            vim.keymap.set("n", "<leader>u", telescope.extensions.undo.undo, {})
            vim.keymap.set("n", "<leader>fb", telescope.extensions.file_browser.file_browser, {})
        end,
    },
}
