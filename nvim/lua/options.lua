-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Tabs and spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Wrapping and max width
vim.opt.textwidth = 120
vim.opt.colorcolumn = { 121 }
vim.opt.breakindent = true
vim.opt.linebreak = true

-- Autocompletion
vim.opt.completeopt:append({ "menuone", "noinsert" })

-- Line numbers and current line
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Clipboard and mouse
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

-- Misc
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.hidden = true
vim.opt.confirm = true
vim.opt.title = true
vim.opt.inccommand = "nosplit"