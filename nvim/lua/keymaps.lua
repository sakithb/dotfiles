vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", {})
vim.keymap.set("n", "<leader>bp", ":bprev<CR>", {})
vim.keymap.set("n", "<leader>bd", ":bd<CR>", {})
vim.keymap.set("n", "<leader>bw", ":bw<CR>", {})
vim.keymap.set("n", "<leader>br", ":e#<CR>", {})

vim.keymap.set("n", "<leader>bf", ":bf<CR>", {})
vim.keymap.set("n", "<leader>b1", ":b1<CR>", {})
vim.keymap.set("n", "<leader>b2", ":b2<CR>", {})
vim.keymap.set("n", "<leader>b3", ":b3<CR>", {})
vim.keymap.set("n", "<leader>b4", ":b4<CR>", {})
vim.keymap.set("n", "<leader>b5", ":b5<CR>", {})
vim.keymap.set("n", "<leader>b6", ":b6<CR>", {})
vim.keymap.set("n", "<leader>b7", ":b7<CR>", {})
vim.keymap.set("n", "<leader>b8", ":b8<CR>", {})
vim.keymap.set("n", "<leader>b9", ":b9<CR>", {})
vim.keymap.set("n", "<leader>bl", ":bl<CR>", {})
vim.keymap.set("n", "<leader>bb", ":b#<CR>", {})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>cd", ":cd %:h|cd ..<CR>", {})
vim.keymap.set("n", "<leader>t", ":terminal<CR>", {})
vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], {})
vim.keymap.set("n", "<C-l>", ":set scrollback=1 | sleep 100m | set scrollback=10000<cr>", {})
vim.keymap.set("t", "<C-l>", [[<c-w><c-l> <c-\><c-n><c-w><c-l>i<c-l>]], {})

vim.keymap.set("v", "<M-r>", '"ry:%s/<C-r>r//gc<left><left><left>', {})
vim.keymap.set("v", "<M-R>", '"ry:s/<C-r>r//gc<left><left><left>', {})
vim.keymap.set("v", "<M-s>", '"sy/<C-r>s/<left>', {})
vim.keymap.set({ "n", "v" }, "<leader>r", ":%s///gc<left><left><left><left>", {})
vim.keymap.set({ "n", "v" }, "<leader>R", ":s///gc<left><left><left><left>", {})
vim.keymap.set({ "n", "v" }, "<leader>s", "//<left>", {})

vim.keymap.set({ "n", "v" }, "<M-y>", '"+y', {})
vim.keymap.set({ "n", "v" }, "<M-p>", '"+p', {})

-- Auto commands

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("Term", {}),
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
		vim.cmd("startinsert!")
	end,
})
