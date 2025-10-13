local map = require("functions/map")

-- Jump to last in stack
map.nnoremaps("<leader>o", "<C-o>")

-- Write all buffers
-- TODO: This makes all the modified buffers pop up quickly, how to fix?
map.nnoremaps("<leader>w", function()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local listed = vim.bo[buf].buflisted
		local modifiable = vim.bo[buf].modifiable
		local modified = vim.bo[buf].modified
		if listed and modifiable and modified then
			vim.api.nvim_exec_autocmds("BufWritePre", { buffer = buf })
		end
	end
	vim.cmd("wa")
end)

-- Fold and unfold
map.nnoremaps("<space>", "za")

-- Always change inner words instead of up to the end
map.nnoremaps("cw", "ciw")
map.nnoremaps("cW", "ciW")

-- Disable highlight when <leader><leader> is pressed
map.noremaps("<leader><leader>", ":noh<cr>")
map.noremaps("<localleader><localleader>", ":noh<cr>")

-- Kitty navigator - either switch Vim panes if present or switch kitty windows
for _, fn in pairs({ map.nnoremaps, map.tnoremaps, map.inoremaps, map.snoremaps }) do
	fn("<C-h>", function()
		vim.cmd("KittyNavigateLeft")
	end)
	fn("<C-j>", function()
		vim.cmd("KittyNavigateDown")
	end)
	fn("<C-k>", function()
		vim.cmd("KittyNavigateUp")
	end)
	fn("<C-l>", function()
		vim.cmd("KittyNavigateRight")
	end)
end

-- Switch between buffers left and with <S-h> and <S-l>
map.nnoremaps("<S-h>", ":BufferPrevious<cr>")
map.nnoremaps("<S-l>", ":BufferNext<cr>")

-- Jump to beginning of line with 0
map.noremaps("0", "^")

-- Jump to matching symbol with ; instead of %
map.nnoremaps(";", "%")
map.vnoremaps(";", "%")

-- Splits
map.nnoremaps("-", ":split<cr>")
map.nnoremaps("|", ":vsplit<cr>")

-- Telescope
map.nnoremaps("<C-p>", function()
	require("telescope.builtin").find_files({ hidden = true })
end)
map.nnoremaps("<C-o>", function()
	require("telescope.builtin").live_grep()
end)

-- Doge
map.nnoremaps("<leader>b", "<Plug>(doge-generate)")
for _, fn in pairs({ map.nnoremaps, map.inoremaps, map.snoremaps }) do
	fn("<Tab", "<Plug>(doge-jump-forward)")
	fn("<S-Tab", "<Plug>(doge-jump-backward)")
end

-- Treesitter
map.nnoremaps("<leader>I", function()
	local data = require("functions.show_pos")()
	require("functions.pretty_scratch")(data)
end)

-- Don't jump with *
map.noremaps("*", "<Plug>(asterisk-z*)")
map.noremaps("#", "<Plug>(asterisk-z#)")
map.noremaps("g*", "<Plug>(asterisk-gz*)")
map.noremaps("g#", "<Plug>(asterisk-gz#)")

-- Prevent {} from landing in jump list
map.nnoremaps("{", "<Cmd>keepjumps normal! {<CR>")
map.nnoremaps("}", "<Cmd>keepjumps normal! }<CR>")

-- nvim-tree
local function tree_focus_or_toggle()
	local api = require("nvim-tree.api").tree
	if api.is_visible() then
		api.focus()
	else
		api.toggle()
	end
end
map.nnoremaps("<C-t>", tree_focus_or_toggle)

-- LSP
map.nnoremaps("<leader>t", function()
	require("trouble").toggle("cascade")
end)
map.nnoremaps("<leader>T", ":TodoTrouble toggle<cr>")
map.nnoremaps("<leader>e", vim.diagnostic.open_float)

local function diag_next()
	vim.diagnostic.jump({ count = 1, severity = { min = vim.diagnostic.severity.INFO } })
end

local function diag_prev()
	vim.diagnostic.jump({ count = -1, severity = { min = vim.diagnostic.severity.INFO } })
end

local function diag_error_next()
	vim.diagnostic.jump({ count = 1, severity = { min = vim.diagnostic.severity.ERROR } })
end

local function diag_error_prev()
	vim.diagnostic.jump({ count = -1, severity = { min = vim.diagnostic.severity.ERROR } })
end

map.nnoremaps("[d", diag_prev)
map.nnoremaps("]d", diag_next)
map.nnoremaps("[D", diag_error_prev)
map.nnoremaps("]D", diag_error_next)
map.nnoremaps("<leader>q", vim.diagnostic.setloclist)

-- Spectre
map.nnoremaps("<leader>S", function()
	require("spectre").open()
end)

-- Copilot
local function ask_copilot(target)
	local copilot = require("CopilotChat")
	return function()
		return copilot.ask(
			vim.fn.input("Ask " .. target .. ": "),
			{ selection = require("CopilotChat.select")[target] }
		)
	end
end

map.nnoremaps("<leader>c", ask_copilot("buffer"))
map.vnoremaps("<leader>c", ask_copilot("visual"))
map.nnoremaps("<leader>C", require("CopilotChat").toggle)

-- Zen
map.nnoremaps("<leader>f", function()
	require("zen-mode").toggle({
		window = {
			width = 1, -- width will be 85% of the editor width
		},
	})
end)

-- WhichKey
map.nnoremaps("<leader>?", function()
	require("which-key").show({ global = false })
end)

-- Fugitive
map.nnoremaps("<leader>hh", function()
	vim.cmd.Git({ mods = { float = true } })
end)
map.nnoremaps("<leader>hc", function()
	vim.cmd.Git({ args = { "commit" } })
end)
map.nnoremaps("<leader>hC", function()
	vim.cmd.Git({ args = { "commit", "--amend" } })
end)
map.nnoremaps("<leader>hp", function()
	vim.cmd.Git({ args = { "push" } })
end)

-- Aider

map.nnoremaps("<leader>a/", "<cmd>Aider toggle<cr>")
map.nnoremaps("<leader>as", "<cmd>Aider send<cr>")
map.vnoremaps("<leader>as", "<cmd>Aider send<cr>")
map.nnoremaps("<leader>ac", "<cmd>Aider command<cr>")
map.nnoremaps("<leader>ab", "<cmd>Aider buffer<cr>")
map.nnoremaps("<leader>aa", "<cmd>Aider add<cr>")
map.nnoremaps("<leader>aA", "<cmd>Aider drop<cr>")
map.nnoremaps("<leader>ar", "<cmd>Aider add readonly<cr>")
map.nnoremaps("<leader>aR", "<cmd>Aider reset<cr>")

-- LSP

local lsp_augroup = vim.api.nvim_create_augroup("UserLspConfig", {})
local function lsb_bind(event)
	vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

	local opts = { buffer = event.buf }
	map.nnoremaps("<leader>G", vim.lsp.buf.declaration, opts)
	map.nnoremaps("<leader>g", vim.lsp.buf.definition, opts)
	map.nnoremaps("<leader>r", vim.lsp.buf.references, opts)
	map.nnoremaps("<leader>i", vim.lsp.buf.implementation, opts)
	map.nnoremaps("K", vim.lsp.buf.hover, opts)

	local ft = vim.bo[event.buf].filetype

	local sig_helps = {
		["ansible"] = ":AnsibleDocVSplit<cr>",
		["yaml.ansible"] = ":AnsibleDocVSplit<cr>",
		["terraform"] = ":OpenDoc<cr>",
	}
	local sig_help = sig_helps[ft] or vim.lsp.buf.signature_help

	map.nnoremaps("<leader>s", sig_help, opts)

	-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
	-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
	-- vim.keymap.set('n', '<space>wl', function()
	--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, opts)
	-- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
	-- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
	-- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
	-- vim.keymap.set('n', '<space>f', function()
	--   vim.lsp.buf.format { async = true }
	-- end, opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_augroup,
	callback = lsb_bind,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_augroup,
	callback = function()
		local clients = vim.lsp.get_clients({ bufnr = 0 })
		for _, client in ipairs(clients) do
			if client and client.supports_method("textDocument/formatting") then
				vim.lsp.buf.format()
				return
			end
		end
	end,
})

-- Filetype specific keybinds

local ft_augroup = vim.api.nvim_create_augroup("UserFileTypeConfig", {})

local ft_maps = {
	["NvimTree"] = {
		["<leader>aa"] = { { map.nnoremaps }, "<cmd>AiderTreeAddFile<cr>" },
		["<leader>aA"] = { { map.nnoremaps }, "<cmd>AiderTreeDropFile<cr>" },
	},
}

for ft, maps in pairs(ft_maps) do
	local ft_bind = function(event)
		for key, args in pairs(maps) do
			local fns = args[1]
			local cmd = args[2]
			for _, fn in ipairs(fns) do
				fn(key, cmd, { buffer = event.buf })
			end
		end
	end

	vim.api.nvim_create_autocmd("FileType", {
		group = ft_augroup,
		pattern = ft,
		callback = ft_bind,
	})
end

-- Overrides

local function switch_and_delete()
	local current_buf = vim.api.nvim_get_current_buf()
	local alt_buf = vim.fn.bufnr("#")
	local target_buf = alt_buf

	if alt_buf == -1 then
		-- Get the previous buffer in the buffer list
		local bufs = vim.api.nvim_list_bufs()
		for _, buf in ipairs(bufs) do
			if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
				target_buf = buf
				break
			end
		end
	end

	-- Iterate over all windows and set the buffer
	local wins = vim.api.nvim_list_wins()
	for _, win in ipairs(wins) do
		local win_buf = vim.api.nvim_win_get_buf(win)
		if win_buf == current_buf then
			if target_buf ~= -1 then
				vim.api.nvim_win_set_buf(win, target_buf)
			else
				vim.cmd("BufferPrevious")
			end
		end
	end

	-- Finally, delete the current buffer
	vim.api.nvim_buf_delete(current_buf, {})
end

local function close_all_but_current()
	local current_buf = vim.api.nvim_get_current_buf()
	local bufs = vim.api.nvim_list_bufs()

	for _, buf in ipairs(bufs) do
		local listed = vim.api.nvim_buf_get_option(buf, "buflisted")
		local modifiable = vim.api.nvim_buf_get_option(buf, "modifiable")
		local modified = vim.api.nvim_buf_get_option(buf, "modified")
		if buf ~= current_buf and listed and modifiable and not modified then
			vim.api.nvim_buf_delete(buf, {})
		end
	end
end

map.nnoremaps("q:", "<nop>")
map.nnoremaps("Q", "<nop>")
map.nnoremaps("q", "<nop>")
map.nnoremaps("<leader>q", "<esc>:Trouble diagnostics close<cr>:qa<cr>")

map.nnoremaps("<leader>z", function()
	vim.cmd("Trouble diagnostics close")
	switch_and_delete()
end)

map.nnoremaps("<leader>Z", function()
	close_all_but_current()
end)

map.nnoremaps("<leader>x", function()
	vim.cmd("close")
end)
