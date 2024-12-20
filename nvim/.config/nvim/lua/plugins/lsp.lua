return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
							},
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								library = { vim.env.VIMRUNTIME },
								checkThirdParty = false,
							},
						},
					},
				},
				tailwindcss = {
					init_options = {
						userLanguages = {
							templ = "html",
							gotmpl = "html",
						}
					},
					settings = {
						includeLanguages = {
							templ = "html",
							gotmpl = "html"
						},
					}
				},
				templ = {
					cmd = { "env", "TEMPL_EXPERIMENT=rawgo", "templ", "lsp" }
				},
				clangd = {
					cmd = { "clangd", "--fallback-style=webkit" },
					init_options = {
						fallbackFlags = { '--std=c99' }
					},
				},
			}
		},
		config = function(_, opts)
			local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			local servers = opts.servers

			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
				handlers = {
					function(server_name)
						if server_name == "rust_analyzer" then
							return
						end

						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
							settings = servers[server_name],
							filetypes = (servers[server_name] or {}).filetypes,
						})
					end,
				}
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
	}
}
