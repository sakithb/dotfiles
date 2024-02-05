return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			local mason_null_ls = require("mason-null-ls")
			local null_ls = require("null-ls")

			-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			mason_null_ls.setup({
				handlers = {
					prettierd = function()
						null_ls.register(null_ls.builtins.formatting.prettierd.with({
							condition = function(utils)
								return utils.root_has_file({
									"prettier.config.js",
									".prettierrc",
									".prettierrc.json",
									".prettierrc.yml",
									".prettierrc.js",
								})
							end,
						}))
					end,
					eslint = function()
						null_ls.register(null_ls.builtins.formatting.eslint.with({
							condition = function(utils)
								return utils.root_has_file({
									".eslintrc.js",
									".eslintrc.json",
									".eslintrc.yml",
								})
							end,
						}))
					end,
				},
			})

			null_ls.setup({
				-- on_attach = function(client, bufnr)
				-- 	if client.supports_method("textDocument/formatting") then
				-- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				-- 		vim.api.nvim_create_autocmd("BufWritePre", {
				-- 			group = augroup,
				-- 			buffer = bufnr,
				-- 			callback = function()
				-- 				vim.lsp.buf.format()
				-- 			end,
				-- 		})
				-- 	end
				-- end,
				on_init = function(new_client, _)
					new_client.offset_encoding = "utf-32"
				end,
			})
		end,
	},
}
