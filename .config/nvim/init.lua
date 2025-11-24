-- Utils

local session_dir = vim.fn.stdpath("state") .. "/sessions/"
if vim.fn.isdirectory(session_dir) == 0 then
	vim.fn.mkdir(session_dir, "p")
end

local function get_session_name()
	local cwd = vim.fn.getcwd()
	local name = cwd:gsub("/", "_")
	return session_dir .. name .. ".vim"
end

local function scroll_preview_docs()
	if vim.fn.pumvisible() == 1 then
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.wo[win].previewwindow then
				vim.api.nvim_win_call(win, function()
					vim.cmd("normal! 4j")
				end)
				return
			end
		end
	end
end

-- Options

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "100"
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 10
vim.opt.pumheight = 10
vim.opt.title = true
vim.opt.confirm = true
vim.opt.background = "dark"
vim.opt.mouse = "a"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.completeopt = { "menuone", "noinsert", "noselect", "preview" }
vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.updatetime = 250
vim.opt.lazyredraw = true
vim.opt.winborder = "single"
vim.opt.sessionoptions = { "buffers", "curdir", "folds", "help", "tabpages", "winsize", "winpos", "terminal",
	"localoptions" }
vim.opt.list = true
vim.opt.listchars = "tab:  ,trail:.,nbsp:+,extends:>"

vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_set_hl(0, "Whitespace", { fg = "#505050" })
vim.api.nvim_set_hl(0, 'Pmenu', { link = 'NormalFloat', default = true })
vim.api.nvim_set_hl(0, 'PmenuSel', { link = 'Visual', default = true })
vim.api.nvim_set_hl(0, 'PmenuExtra', { link = 'Comment', default = true })
vim.api.nvim_set_hl(0, 'PmenuKind', { link = 'Type', default = true })

-- Keymaps

vim.g.mapleader = " "

-- config
vim.keymap.set("n", "<leader>ce", ":e $MYVIMRC<CR>", { desc = "Edit config" })
vim.keymap.set("n", "<leader>cr", ":so $MYVIMRC<CR>", { desc = "Reload config" })

-- buffers
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Goto next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Goto previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdel<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>ba", ":enew<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>bb", ":e#<CR>", { desc = "Switch to last buffer" })
vim.keymap.set("n", "<leader>bt", ":term<CR>", { desc = "Create terminal buffer" })

-- tabs
vim.keymap.set('n', '<leader>tn', ':tabnext<CR>', { desc = 'Goto next tab' })
vim.keymap.set('n', '<leader>tp', ':tabprevious<CR>', { desc = 'Goto previous tab' })
vim.keymap.set('n', '<leader>td', ':tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set('n', '<leader>ta', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>t>', ':tabmove +1<CR>', { desc = 'Move tab right' })
vim.keymap.set('n', '<leader>t<', ':tabmove -1<CR>', { desc = 'Move tab left' })

-- windows
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<leader>wH", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<leader>wJ", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<leader>wK", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<leader>wL", ":vertical resize +2<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<leader>w-", ":split<CR>", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>w/", ":vsplit<CR>", { desc = "Split vertically" })

-- editing
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set("n", "r", ":%s///gc<left><left><left><left>", { desc = "Replace in file" })
vim.keymap.set("v", "r", ":s///gc<left><left><left><left>", { desc = "Replace in selection" })
vim.keymap.set({ "n", "v" }, "<M-y>", "\"+y", { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<M-p>", "\"+p", { desc = "Paste to system clipboard" })
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Discard search highlights:" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("i", "<C-f>", scroll_preview_docs, { desc = "Scroll preview docs" })
vim.keymap.set("i", "<C-space>","<C-x><C-o>", { desc = "Trigger completion" })

function setupLspKeymaps(buf)
	vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = buf, desc = "Rename symbol" })
	vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = buf, desc = "Format" })
	vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = buf, desc = "List code actions" })
	vim.keymap.set("n", "<leader>lc", vim.lsp.buf.declaration, { buffer = buf, desc = "Goto declaration" })
	vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { buffer = buf, desc = "Goto definition" })
	vim.keymap.set("n", "<leader>ly", vim.lsp.buf.type_definition, { buffer = buf, desc = "Goto type definition" })
	vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { buffer = buf, desc = "Goto implementation" })

	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf, desc = "Show documentation" })
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = buf, desc = "Show signature help" })
	vim.keymap.set("n", "<A-k>", vim.diagnostic.open_float, { buffer = buf, desc = "Show diagnostics in the line" })

	vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = buf, desc = "Goto next diagnostic" })
	vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { buffer = buf, desc = "Goto previous diagnostic" })
end

function setupFilesKeymaps()
	vim.keymap.set("n", "<leader><CR>", MiniFiles.open, { desc = "Open file browser" })
end

function setupPickKeymaps()
	vim.keymap.set("n", "<leader>ff", ":Pick files<CR>", { desc = "Pick files" })
	vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>", { desc = "Pick buffers" })

	vim.keymap.set("n", "<leader>ss", ":Pick grep_live<CR>", { desc = "Search across files" })
	vim.keymap.set("n", "<leader>sh", ":Pick help<CR>", { desc = "Search help" })
end

-- function setupDapKeymaps()
--     local dap = require("dap")
--     local widgets = require("dap.ui.widgets")
--
--     local function logpoint()
--         dap.set_breakpoint(nil, nil, vim.fn.input("Log: "))
--     end
--
--     local function frames()
--         widgets.centered_float(widgets.frames)
--     end
--
--     local function scopes()
--         widgets.centered_float(widgets.scopes)
--     end
--
--     local function threads()
--         widgets.centered_float(widgets.threads)
--     end
--
--     local function expression()
--         widgets.cursor_float(widgets.expression)
--     end
--
--     vim.keymap.set("n", "<leader>dd", dap.continue, { desc = "Debug: continue or start session" })
--     vim.keymap.set("n", "<leader>ddr", dap.restart, { desc = "Debug: restart session" })
--     vim.keymap.set("n", "<leader>ddp", dap.pause, { desc = "Debug: pause session" })
--     vim.keymap.set("n", "<leader>ddl", dap.run_last, { desc = "Debug: start last session" })
--     vim.keymap.set("n", "<leader>ddt", dap.terminate, { desc = "Debug: terminate session" })
--
--     vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Debug: open repl" })
--     vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { desc = "Debug: run to cursor" })
--
--     vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Debug: step over" })
--     vim.keymap.set("n", "<leader>dni", dap.step_into, { desc = "Debug: step into" })
--     vim.keymap.set("n", "<leader>dno", dap.step_out, { desc = "Debug: step out" })
--
--     vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: toggle breakpoint" })
--     vim.keymap.set("n", "<leader>dbl", logpoint, { desc = "Debug: set logpoint" })
--     vim.keymap.set("n", "<leader>dbs", dap.list_breakpoints, { desc = "Debug: list breakpoints" })
--     vim.keymap.set("n", "<leader>dbc", dap.clear_breakpoints, { desc = "Debug: clear breakpoints" })
--
--
--     vim.keymap.set({"n", "v"}, "<C-S-k>", widgets.hover, { desc = "Debug: show expression" })
--     vim.keymap.set("n", "<leader>df", frames, { desc = "Debug: show stackframes" })
--     vim.keymap.set("n", "<leader>dfu", dap.up, { desc = "Debug: goto frame above" })
--     vim.keymap.set("n", "<leader>dfd", dap.down, { desc = "Debug: goto frame below" })
--     vim.keymap.set("n", "<leader>dff", dap.down, { desc = "Debug: focus current frame" })
--     vim.keymap.set("n", "<leader>ds", scopes, { desc = "Debug: show scopes" })
--     vim.keymap.set("n", "<leader>de", expression, { desc = "Debug: show expression" })
--     vim.keymap.set("n", "<leader>dt", threads, { desc = "Debug: show threads" })
-- end
--

-- Autocommands

local augroup = vim.api.nvim_create_augroup("UserConfig", {})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, {
				convert = function(item)
					local abbr = item.label
					local menu = item.detail or ""

					abbr = abbr:gsub("%b()", ""):gsub("%b{}", "")
					abbr = abbr:match("[%w_.]+.*") or abbr

					local abbr_max = 30 - #menu
					abbr = #abbr > abbr_max and abbr:sub(1, abbr_max - 1) .. "…" or abbr

					return { abbr = abbr, menu = menu }
				end,
			})
		end

		local settings = client.config.settings

		if settings and settings.editor then
			if settings.editor.tabSize ~= nil then
				vim.api.nvim_set_option_value("tabstop", settings.editor.tabSize, { buf = args.buf })
			end

			if settings.editor.insertSpaces ~= nil then
				vim.api.nvim_set_option_value("expandtav", settings.editor.insertSpaces, { buf = args.buf })
			end
		end

		setupLspKeymaps(args.buf)
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	callback = function()
		if vim.v.event.status == 0 then
			vim.api.nvim_buf_delete(0, {})
		end
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	group = augroup,
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	callback = function()
		local dir = vim.fn.expand('<afile>:p:h')
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, 'p')
		end
	end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	group = augroup,
	callback = function()
		if vim.fn.argc() == 0 then
			vim.cmd("mksession! " .. get_session_name())
		end
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = augroup,
	nested = true,
	callback = function()
		if vim.fn.argc() == 0 then
			local session_file = get_session_name()
			if vim.fn.filereadable(session_file) == 1 then
				vim.cmd("source " .. session_file)
			end
		end
	end,
})

vim.api.nvim_create_autocmd("CompleteChanged", {
	callback = function()
		local event = vim.v.event
		if not event or not event.completed_item then return end

		local cy = event.row
		local cx = event.col
		local cw = event.width
		local ch = event.height

		local item = event.completed_item
		local lsp_item = item.user_data and item.user_data.nvim and item.user_data.nvim.lsp.completion_item
		local client = vim.lsp.get_clients({ bufnr = 0 })[1]

		if not client or not lsp_item then return end

		client:request('completionItem/resolve', lsp_item, function(_, result)
			vim.cmd("pclose")

			if result and result.documentation then
				local docs = result.documentation.value or result.documentation
				if type(docs) == "table" then docs = table.concat(docs, "\n") end
				if not docs or docs == "" then return end

				local buf = vim.api.nvim_create_buf(false, true)
				vim.bo[buf].bufhidden = 'wipe'

				local contents = vim.lsp.util.convert_input_to_markdown_lines(docs)

				local padded_contents = {}
				local max_content_width = 0

				for _, line in ipairs(contents) do
					local new_line = " " .. line .. " "
					table.insert(padded_contents, new_line)
					if #new_line > max_content_width then
						max_content_width = #new_line
					end
				end

				vim.api.nvim_buf_set_lines(buf, 0, -1, false, padded_contents)
				vim.treesitter.start(buf, "markdown")

				local dw = math.min(max_content_width, 60)
				local dh = math.min(#padded_contents, ch)

				local dx = cx + cw + 1
				local anchor = "NW"

				if dx + dw > vim.o.columns then
					dx = cx - 1
					anchor = "NE"
				end

				local win = vim.api.nvim_open_win(buf, false, {
					relative = "editor",
					row = cy,
					col = dx,
					width = dw,
					height = dh,
					anchor = anchor,
					border = "none",
					style = "minimal",
					zindex = 60,
				})

				vim.wo[win].conceallevel = 2
				vim.wo[win].wrap = false
				vim.wo[win].previewwindow = true
			end
		end)
	end,
})

vim.api.nvim_create_autocmd("CompleteDone", {
	callback = function()
		vim.cmd("pclose")
	end
})

-- Plugins

vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/mason-org/mason.nvim" },

	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
	{ src = "https://github.com/nvim-mini/mini.icons" },
	{ src = "https://github.com/nvim-mini/mini.statusline" },

	{ src = "https://github.com/nvim-mini/mini.files" },
	{ src = "https://github.com/nvim-mini/mini.pick" }
})

-- Setup lsp
vim.lsp.enable({ "lua_ls", "ts_ls", "svelte" })
require("mason").setup()

-- Setup treesitter
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true
	}
})

-- Appearance
vim.cmd("colorscheme gruvbox")
require("mini.icons").setup()
require("mini.statusline").setup()

-- Functional
require("mini.files").setup()
setupFilesKeymaps()
require("mini.pick").setup()
setupPickKeymaps()
