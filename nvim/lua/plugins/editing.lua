return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"lukas-reineke/lsp-format.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				on_init = function(new_client, _)
					new_client.offset_encoding = "utf-32"
				end,
				on_attach = require("lsp-format").on_attach,
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.diagnostics.eslint,
				},
			})
		end,
	},
}
