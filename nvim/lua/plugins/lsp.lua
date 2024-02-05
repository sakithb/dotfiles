vim.diagnostic.config({
	update_in_insert = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, opts)
		vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)

		vim.keymap.set("n", "<S-k>", vim.lsp.buf.hover, opts)
		vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set({ "n", "i" }, "<M-k>", vim.diagnostic.open_float, {})
	end,
})

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local server_config = {
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
					}

					-- if server_name == "rust_analyzer" then
					-- 	server_config = vim.tbl_extend("force", server_config, {
					-- 		settings = {
					-- 			["rust-analyzer"] = {
					-- 				diagnostics = {
					-- 					enable = true,
					-- 					experimental = {
					-- 						enable = true,
					-- 					},
					-- 				},
					-- 			},
					-- 		},
					-- 	})
					-- end

					require("lspconfig")[server_name].setup(server_config)
				end,
			})
		end,
	},
}
