-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Tabs and spaces
vim.opt.tabstop = 4
--vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
--vim.opt.expandtab = true
--vim.opt.autoindent = true
--vim.opt.smartindent = true

-- Wrapping and max width
vim.opt.colorcolumn = { 121 }
vim.opt.breakindent = true
vim.opt.linebreak = true

-- Autocompletion
vim.opt.completeopt:append({ "menu", "menuone", "preview", "noinsert" })

-- Line numbers and current line
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.scrolloff = 10

-- Misc
vim.opt.mouse = "a"
vim.opt.pumheight = 10
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.hidden = true
vim.opt.confirm = true
vim.opt.title = true
vim.opt.inccommand = "nosplit"
vim.opt.signcolumn = "yes"
vim.opt.sessionoptions:append("globals")
vim.opt.updatetime = 250

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.have_nerd_font = true

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.diagnostic.config({
	update_in_insert = true,
})

vim.filetype.add({
	extension = {
		gotmpl = "gotmpl",
	},
})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}

	opts.border = opts.border or "single"
	opts.max_width = opts.max_width or 100
	opts.max_height = opts.max_height or 20

	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local orig_buf_format = vim.lsp.buf.format
function vim.lsp.buf.format(opts, ...)
	opts = opts or {}

	opts.formatting_options = {
		tabSize = vim.g.shiftwidth,
		insertSpaces = vim.g.expandtab,
	}

	opts.filter = function(client)
		if vim.bo.filetype == "templ" then
			return client.name == "templ"
		end

		return true
	end

	return orig_buf_format(opts, ...)
end
