vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", {})
vim.keymap.set("n", "<leader>bp", ":bprev<CR>", {})
vim.keymap.set("n", "<leader>bd", ":bd<CR>", {})
vim.keymap.set("n", "<leader>bw", ":bw<CR>", {})
vim.keymap.set("n", "<leader>br", ":e#<CR>", {})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>cd", ":cd %:h|cd ..<CR>", {})
vim.keymap.set("n", "<leader>t", ":terminal<CR>", {})
vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], {})
vim.keymap.set("n", "<C-l>", ":set scrollback=1 | sleep 100m | set scrollback=10000<cr>", {})
vim.keymap.set("t", "<C-l>", [[<c-w><c-l> <c-\><c-n><c-w><c-l>i<c-l>]], {})

-- Auto commands

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("Term", {}),
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
		vim.cmd("startinsert!")
	end,
})
