vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80,120"
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 10
vim.opt.pumheight = 10
vim.opt.showmode = false
vim.opt.title = true
vim.opt.confirm = true
vim.opt.background = "dark"
vim.opt.mouse = "c"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.completeopt = "menu,menuone,preview,noinsert"
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true
vim.opt.backupdir = vim.fn.stdpath("data") .. "/backup"
vim.opt.backup = true

vim.opt.updatetime = 600
vim.opt.timeoutlen = 300

vim.filetype.add({
  extension = {
    vert = "glsl",
    frag  = "glsl"
  },
})
