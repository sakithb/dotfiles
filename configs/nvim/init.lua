-- Utils

local session_dir = vim.fn.stdpath("state") .. "/sessions/"
vim.fn.mkdir(session_dir, "p")

local function get_session_name()
	local cwd = vim.fn.getcwd()
	local name = cwd:gsub("/", "_")
	return session_dir .. name .. ".vim"
end

local function fetch_git_info(bufnr)
	if vim.bo[bufnr].buftype ~= "" then
		vim.b[bufnr].git_status = ""
		return
	end

	local file = vim.api.nvim_buf_get_name(bufnr)
	if file == "" then return end
	local cwd = vim.fs.dirname(file)

	vim.system({ "git", "status", "--porcelain", "-b" }, { text = true, cwd = cwd }, function(obj)
		if obj.code == 0 then
			local output = obj.stdout
			local branch = output:match("^##%s+([^%.%s]+)") or "DETACHED"
			local is_dirty = output:match("\n.")
			local icon = is_dirty and "*" or ""
			vim.b[bufnr].git_status = " " .. branch .. icon .. " "
		else
			vim.b[bufnr].git_status = ""
		end
	end)
end

local function get_diag()
	local s = vim.diagnostic.status()

	if s ~= "" then
		s = s:gsub("%%#Diagnostic", "%%#StDiagnostic")
		s = s:gsub("^(%%#.-#)", "%1  ")
		s = s:gsub("(%%##)$", "  %1")
	end

	return s
end

local function get_size()
	local size = vim.fn.getfsize(vim.fn.expand("%"))
	if size <= 0 then return "" end
	return size < 1024 and size .. "b" or string.format("%.1fk", size / 1024)
end

local function get_search()
	if vim.v.hlsearch == 0 then return "" end
	local ok, count = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 500 })
	if not ok or next(count) == nil or count.total == 0 then return "" end
	return string.format(" [%d/%d] ", count.current, count.total)
end

local mode_map = {
	["n"] = { "StModeNormal", "NORMAL" },
	["i"] = { "StModeInsert", "INSERT" },
	["v"] = { "StModeVisual", "VISUAL" },
	["V"] = { "StModeVisual", "V-LINE" },
	["\22"] = { "StModeVisual", "V-BLOCK" },
	["R"] = { "StModeReplace", "REPLACE" },
	["c"] = { "StModeCmd", "COMMAND" },
	["t"] = { "StModeTerminal", "TERMINAL" },
	["nt"] = { "StModeTerminal", "TERM-N" },
}

---@diagnostic disable-next-line: lowercase-global
function custom_statusline()
	local m = mode_map[vim.api.nvim_get_mode().mode] or mode_map["n"]
	local mode_hl, mode_text = m[1], m[2]

	return table.concat({
		"%#" .. mode_hl .. "#  " .. mode_text .. "  ",
		"%#StInfo#", vim.b.git_status or "", get_diag(),
		"%#StBody# %f %m %r",
		"%=",
		"%#StInfo# %y ", get_size(), " ",
		"%#" .. mode_hl .. "#", get_search(), " %l:%c "
	})
end

local function scroll_preview_docs(dir)
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.wo[win].previewwindow then
			vim.api.nvim_win_call(win, function()
				if dir == "up" then
					vim.cmd("normal! 4k")
				elseif dir == "down" then
					vim.cmd("normal! 4j")
				end
			end)
			return
		end
	end
end

local function open_mini_files()
	local files = require("mini.files")
	local buf = vim.api.nvim_get_current_buf()
	local bo = vim.bo[buf]

	if bo.buftype == "" and bo.modifiable and bo.buflisted then
		files.open(vim.api.nvim_buf_get_name(buf))
	else
		files.open(files.get_latest_path())
	end
end

local function open_mini_pick_lsp_references()
	local pick = require("mini.pick")

	vim.lsp.buf.references(nil, {
		on_list = function(data)
			local items = data.items

			for _, item in ipairs(items) do
				local path = item.filename or (item.bufnr and vim.api.nvim_buf_get_name(item.bufnr)) or ""
				path = vim.fn.fnamemodify(path, ":p:.")
				local lnum = item.lnum or 1
				local col = item.col or 1

				item.loc_header = string.format("%s:%d:%d", path, lnum, col)
				item.content = vim.trim(item.text or "")
			end

			for _, item in ipairs(items) do
				item.text = string.format("%s │ %s", item.loc_header, item.content)
			end

			table.sort(items, function(a, b)
				local pa, pb = a.filename or "", b.filename or ""
				if pa ~= pb then return pa < pb end
				return (a.lnum or 0) < (b.lnum or 0)
			end)

			pick.start({
				source = {
					name = "LSP References",
					items = items,
					choose = function(item)
						local target_win = pick.get_picker_state().windows.target

						if vim.api.nvim_win_is_valid(target_win) then
							vim.api.nvim_set_current_win(target_win)
						end

						if item.bufnr and vim.api.nvim_buf_is_valid(item.bufnr) then
							vim.api.nvim_win_set_buf(target_win, item.bufnr)
						elseif item.filename then
							vim.cmd("edit " .. vim.fn.fnameescape(item.filename))
						end

						vim.api.nvim_win_set_cursor(target_win, { item.lnum or 1, (item.col or 1) - 1 })
					end,
					show = function(buf_id, items_to_show, query)
						pick.default_show(buf_id, items_to_show, query, { show_icons = false })

						local ns = vim.api.nvim_create_namespace("MiniPickReferences")
						vim.api.nvim_buf_clear_namespace(buf_id, ns, 0, -1)

						for i, item in ipairs(items_to_show) do
							local sep_start = item.text:find("│")
							if sep_start then
								vim.api.nvim_buf_set_extmark(buf_id, ns, i - 1, 0, {
									end_col = sep_start - 1,
									hl_group = "Comment",
									priority = 199,
								})
							end
						end
					end
				}
			})
		end
	})
end

local function open_mini_pick_lsp_diagnostics()
	local pick = require("mini.pick")
	local raw_diagnostics = vim.diagnostic.get(nil)
	local items = {}

	for _, diag in ipairs(raw_diagnostics) do
		local buf_name = vim.api.nvim_buf_get_name(diag.bufnr)
		local path = vim.fn.fnamemodify(buf_name, ":p:.")
		local severity_map = { [1] = "E", [2] = "W", [3] = "I", [4] = "H" }

		table.insert(items, {
			text = string.format("[%s] %s │ %s", severity_map[diag.severity] or "?", path, diag.message),
			bufnr = diag.bufnr,
			lnum = diag.lnum + 1,
			col = diag.col,
			severity = diag.severity
		})
	end

	table.sort(items, function(a, b)
		if a.severity ~= b.severity then return a.severity < b.severity end
		return a.text < b.text
	end)

	pick.start({
		source = {
			name = "LSP Diagnostics",
			items = items,
			choose = function(item)
				local target_win = pick.get_picker_state().windows.target

				if vim.api.nvim_win_is_valid(target_win) then
					vim.api.nvim_set_current_win(target_win)
				end

				if item.bufnr and vim.api.nvim_buf_is_valid(item.bufnr) then
					vim.api.nvim_win_set_buf(target_win, item.bufnr)
				elseif item.filename then
					vim.cmd("edit " .. vim.fn.fnameescape(item.filename))
				end

				vim.api.nvim_win_set_cursor(target_win, { item.lnum or 1, (item.col or 1) - 1 })
			end,
			show = function(buf_id, items_to_show, query)
				pick.default_show(buf_id, items_to_show, query, { show_icons = false })

				local ns = vim.api.nvim_create_namespace("MiniPickDiagnostics")
				vim.api.nvim_buf_clear_namespace(buf_id, ns, 0, -1)

				local hl_map = {
					[1] = "DiagnosticError",
					[2] = "DiagnosticWarn",
					[3] = "DiagnosticInfo",
					[4] = "DiagnosticHint"
				}

				for i, item in ipairs(items_to_show) do
					if hl_map[item.severity] then
						vim.api.nvim_buf_set_extmark(buf_id, ns, i - 1, 0, {
							end_row = i,
							hl_group = hl_map[item.severity],
							priority = 199
						})
					end
				end
			end
		}
	})
end

local function delete_buffer_from_picker(force)
	local pick = require("mini.pick")
	local matches = pick.get_picker_matches()

	if matches.marked_inds ~= nil and #matches.marked_inds > 0 then
		for _, idx in ipairs(matches.marked_inds) do
			vim.api.nvim_buf_delete(matches.all[idx].bufnr, { force = force })
			matches.all[idx] = nil
		end
	else
		vim.api.nvim_buf_delete(matches.current.bufnr, { force = force })
		matches.all[matches.current_ind] = nil
	end

	local items = {}
	for _, item in pairs(matches.all) do
		if item ~= nil then
			table.insert(items, item)
		end
	end

	pick.set_picker_items(items, nil)
end

--- @param sort_method "id" | "lastused"
local function list_terminals(sort_method)
	local terms = {}
	local all_bufs = vim.fn.getbufinfo({ buflisted = 0 })

	for _, b in ipairs(all_bufs) do
		if vim.api.nvim_buf_is_valid(b.bufnr) and vim.bo[b.bufnr].buftype == "terminal" then
			table.insert(terms, {
				bufnr = b.bufnr,
				text = vim.b[b.bufnr].term_title or b.name,
				lastused = b.lastused
			})
		end
	end

	if sort_method == "lastused" then
		table.sort(terms, function(a, b) return a.lastused > b.lastused end)
	else
		table.sort(terms, function(a, b) return a.bufnr < b.bufnr end)
	end

	return terms
end

local function cycle_terminal(direction)
	local terms = list_terminals("id")
	if #terms == 0 then return end

	local current_buf = vim.api.nvim_get_current_buf()
	local current_idx = 0

	for i, t in ipairs(terms) do
		if t.bufnr == current_buf then
			current_idx = i
			break
		end
	end

	local target_idx
	if direction == "next" then
		target_idx = (current_idx % #terms) + 1
	else
		target_idx = ((current_idx - 2) % #terms) + 1
	end

	vim.api.nvim_set_current_buf(terms[target_idx].bufnr)
end

local function goto_last_terminal()
	local terms = list_terminals("lastused")
	if #terms == 0 then return end

	local target = terms[1].bufnr
	if target == vim.api.nvim_get_current_buf() and #terms > 1 then
		target = terms[2].bufnr
	end

	vim.api.nvim_set_current_buf(target)
end

local function goto_next_terminal()
	cycle_terminal("next")
end

local function goto_prev_terminal()
	cycle_terminal("prev")
end

local function open_mini_pick_terminals()
	local pick = require("mini.pick")
	local target_win = vim.api.nvim_get_current_win()

	pick.start({
		mappings = {
			wipeout = {
				char = "<C-d>",
				func = function() delete_buffer_from_picker(true) end
			},
		},
		source = {
			name = "Terminals",
			items = list_terminals("lastused"),
			choose = function(item)
				if vim.api.nvim_win_is_valid(target_win) then
					vim.api.nvim_win_set_buf(target_win, item.bufnr)
				end
			end,
		},
	})
end

local function open_mini_pick_buffers()
	local pick = require("mini.pick")
	local all_bufs = vim.fn.getbufinfo({ buflisted = 1 })
	local bufs = {}

	for _, b in ipairs(all_bufs) do
		if vim.api.nvim_buf_is_valid(b.bufnr) and vim.bo[b.bufnr].buftype ~= "terminal" then
			table.insert(bufs, b)
		end
	end

	table.sort(bufs, function(a, b)
		return a.lastused > b.lastused
	end)

	local items = {}
	for _, buf in ipairs(bufs) do
		local name = buf.name
		if name == "" then
			name = "[No Name]"
		else
			name = vim.fn.fnamemodify(name, ":~:.")
		end

		if buf.changed == 1 then
			name = "[+] " .. name
		end

		table.insert(items, {
			text = name,
			bufnr = buf.bufnr,
		})
	end

	pick.start({
		source = {
			name = "Buffers",
			items = items,
			show = function(buf_id, items_arr, query)
				pick.default_show(buf_id, items_arr, query, {
					show_icons = true,
				})
			end,
		},
		mappings = {
			wipeout = {
				char = "<C-d>",
				func = function()
					delete_buffer_from_picker(false)
				end,
			},
		},
	})
end

local function create_session()
	local session_file = get_session_name()
	vim.cmd("mksession! " .. session_file)
	vim.t.session_path = session_file
	vim.print("Session created!")
end


-- Options

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "100"
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.statusline = "%!v:lua.custom_statusline()"
vim.opt.showmode = false
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
vim.opt.foldlevel = 99

vim.opt.completeopt = { "menuone", "noinsert", "noselect", "preview" }
vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.updatetime = 250
vim.opt.lazyredraw = true
vim.opt.winborder = "single"
vim.opt.sessionoptions = { "buffers", "curdir", "folds", "help", "tabpages", "winsize", "winpos", "localoptions" }
vim.opt.list = true
vim.opt.listchars = "tab:  ,trail:.,nbsp:+,extends:>"
vim.opt.shortmess:append("s")

vim.diagnostic.config({ virtual_text = true })

-- Keymaps

vim.g.mapleader = " "

-- config
vim.keymap.set("n", "<leader>ce", ":e $MYVIMRC<CR>", { desc = "Edit config" })
vim.keymap.set("n", "<leader>cr", ":so $MYVIMRC<CR>", { desc = "Reload config" })

-- buffers
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Goto next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Goto previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdel<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>ba", ":enew<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>bb", ":e#<CR>", { desc = "Switch to last buffer" })

-- terminals
vim.keymap.set("n", "<leader>tn", goto_next_terminal, { desc = "Goto next terminal" })
vim.keymap.set("n", "<leader>tp", goto_prev_terminal, { desc = "Goto previous terminal" })
vim.keymap.set("n", "<leader>td", ":bdel!<CR>", { desc = "Delete terminal" })
vim.keymap.set("n", "<leader>ta", ":term<CR>", { desc = "Create terminal" })
vim.keymap.set("n", "<leader>tt", goto_last_terminal, { desc = "Switch to last terminal" })

-- windows
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<leader>wH", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<leader>wJ", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<leader>wK", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<leader>wL", ":vertical resize +2<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<leader>wd", ":split<CR>", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>wr", ":vsplit<CR>", { desc = "Split vertically" })

-- editing
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set("n", "rr", ":%s///gc<left><left><left><left>", { desc = "Replace in file" })
vim.keymap.set("v", "rr", ":s///gc<left><left><left><left>", { desc = "Replace in selection" })
vim.keymap.set({ "n", "v" }, "<M-y>", "\"+y", { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<M-p>", "\"+p", { desc = "Paste to system clipboard" })
vim.keymap.set({ "n", "v" }, "<Esc>", ":nohlsearch<CR>", { desc = "Discard search highlights:" })
vim.keymap.set("t", "<C-t>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("i", "<C-f>", function() scroll_preview_docs("down") end, { desc = "Scroll preview docs" })
vim.keymap.set("i", "<C-b>", function() scroll_preview_docs("up") end, { desc = "Scroll preview docs" })
vim.keymap.set("i", "<C-space>", "<C-x><C-o>", { desc = "Trigger completion" })

-- sessions
vim.keymap.set("n", "sc", create_session, { desc = "Create session" })

local function setupLspKeymaps(buf)
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

	vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.jump({ count = 1, float = true }) end,
		{ buffer = buf, desc = "Goto next diagnostic" })
	vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.jump({ count = -1, float = true }) end,
		{ buffer = buf, desc = "Goto previous diagnostic" })
end

local function setupFilesKeymaps()
	vim.keymap.set("n", "<leader><CR>", open_mini_files, { desc = "Open file browser" })
end

local function setupPickKeymaps()
	local pick = require("mini.pick")

	vim.keymap.set("n", "<leader>ff", pick.builtin.files, { desc = "Pick files" })
	vim.keymap.set("n", "<leader><space>", open_mini_pick_buffers, { desc = "Pick buffers" })
	vim.keymap.set("n", "<leader>ft", open_mini_pick_terminals, { desc = "Pick terminals" })
	vim.keymap.set("n", "<leader>fg", pick.builtin.grep_live, { desc = "Search across files" })

	vim.keymap.set("n", "<leader>llr", open_mini_pick_lsp_references, { desc = "Pick LSP references" })
	vim.keymap.set("n", "<leader>lld", open_mini_pick_lsp_diagnostics, { desc = "Pick LSP diagnostics" })
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
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then return end

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
		local mark = vim.api.nvim_buf_get_mark(0, "\"")
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.buflisted = false
		vim.cmd("startinsert")
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
		local dir = vim.fn.expand("<afile>:p:h")
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	group = augroup,
	callback = function()
		if vim.fn.argc() == 0 then
			local session_file = get_session_name()
			if vim.fn.filereadable(session_file) == 1 then
				vim.cmd("mksession! " .. session_file)
			end
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
				vim.t.session_path = session_file
			end
		end
	end,
})

vim.api.nvim_create_autocmd("CompleteChanged", {
	group = augroup,
	callback = function()
		local event = vim.v.event
		if not event then return end

		local cy = event.row
		local cx = event.col
		local cw = event.width
		local ch = event.height

		local item = event.completed_item
		if not item then return end

		local lsp_item = item.user_data and item.user_data.nvim and item.user_data.nvim.lsp.completion_item
		if not lsp_item then return end

		local client = vim.lsp.get_clients({ bufnr = 0 })[1]
		if not client then return end

		client:request("completionItem/resolve", lsp_item, function(_, result)
			vim.cmd("pclose")

			if result and result.documentation then
				local docs = result.documentation.value or result.documentation
				if type(docs) == "table" then docs = table.concat(docs, "\n") end
				if not docs or docs == "" then return end

				local buf = vim.api.nvim_create_buf(false, true)
				vim.bo[buf].bufhidden = "wipe"

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
				local dh = math.min(#padded_contents, math.max(vim.o.scrolloff, ch))

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
				vim.wo[win].wrap = true
				vim.wo[win].previewwindow = true
			end
		end)
	end,
})

vim.api.nvim_create_autocmd("CompleteDone", {
	group = augroup,
	callback = function()
		vim.cmd("pclose")
	end
})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
	group = augroup,
	callback = function(args)
		fetch_git_info(args.buf)
	end
})

vim.api.nvim_create_autocmd('FileType', {
	callback = function()
		pcall(vim.treesitter.start)

		vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		vim.wo[0][0].foldmethod = 'expr'

		-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- Plugins

vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },

	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
	{ src = "https://github.com/nvim-mini/mini.icons" },

	{ src = "https://github.com/nvim-mini/mini.files" },
	{ src = "https://github.com/nvim-mini/mini.pick" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

-- Setup lsp
vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"svelte",
	"phpactor",
	"bashls",
	"nixd",
	"ols",
	"qmlls",
	"pylsp"
})

vim.lsp.config("phpactor", {
	root_markers = { "composer.json", ".phpactor.json", ".phpactor.yml", ".git" },
})

vim.lsp.config("nixd", {
	formattings = {
		command = { "nix", "fmt" }
	}
})

-- local packages = {
--     "lua-language-server",
--     "typescript-language-server",
--     "svelte-language-server",
--     "phpactor",
--     "bash-language-server",
--     "ols",
--     "qmlls"
-- }

require("nvim-treesitter").install({
	"javascript",
	"typescript",
	"jsx",
	"tsx",
	"bash",
	"nix",
	"qmljs",
	"qmldir",
	"html",
	"css",
	"php",
	"odin",
	"yaml",
	"json",
	"svelte",
	"blade",
	"python"
})

-- Appearance
vim.cmd("colorscheme gruvbox")

vim.api.nvim_set_hl(0, "Whitespace", { fg = "#505050" })
vim.api.nvim_set_hl(0, "Pmenu", { link = "NormalFloat", default = true })
vim.api.nvim_set_hl(0, "PmenuSel", { link = "Visual", default = true })
vim.api.nvim_set_hl(0, "PmenuExtra", { link = "Comment", default = true })
vim.api.nvim_set_hl(0, "PmenuKind", { link = "Type", default = true })

vim.api.nvim_set_hl(0, "StModeNormal", { bg = "#a89984", fg = "#282828", bold = true })
vim.api.nvim_set_hl(0, "StModeInsert", { bg = "#83a598", fg = "#282828", bold = true })
vim.api.nvim_set_hl(0, "StModeVisual", { bg = "#fe8019", fg = "#282828", bold = true })
vim.api.nvim_set_hl(0, "StModeReplace", { bg = "#fb4934", fg = "#282828", bold = true })
vim.api.nvim_set_hl(0, "StModeTerminal", { bg = "#b8bb26", fg = "#282828", bold = true })
vim.api.nvim_set_hl(0, "StModeCmd", { bg = "#b8bb26", fg = "#282828", bold = true })
vim.api.nvim_set_hl(0, "StInfo", { bg = "#504945", fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "StBody", { bg = "#3c3836", fg = "#a89984" })

local diag_highlights = {
	"DiagnosticSignError",
	"DiagnosticSignWarn",
	"DiagnosticSignInfo",
	"DiagnosticSignHint",
}

for _, hl in ipairs(diag_highlights) do
	local existing = vim.api.nvim_get_hl(0, { name = hl, link = false })
	local new_hl = "St" .. hl
	vim.api.nvim_set_hl(0, new_hl, {
		fg = existing.fg,
		bg = "#504945",
		bold = existing.bold
	})
end

require("mini.icons").setup()
require("render-markdown").setup({
	sign = {
		enabled = false
	}
})

-- Functional
require("mini.files").setup({
	mappings = {
		close = "<Esc>",
		synchronize = "<CR>"
	}
})
setupFilesKeymaps()
require("mini.pick").setup()
setupPickKeymaps()
setupPickKeymaps()
