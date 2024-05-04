local map = vim.keymap.set

local nnoremaps = function(lhs, rhs, opts)
	map("n", lhs, rhs, vim.tbl_extend("force", { noremap = true, silent = true }, opts or {}))
end

local inoremaps = function(lhs, rhs, opts)
	map("i", lhs, rhs, vim.tbl_extend("force", { noremap = true, silent = true }, opts or {}))
end

local snoremaps = function(lhs, rhs, opts)
	map("s", lhs, rhs, vim.tbl_extend("force", { noremap = true, silent = true }, opts or {}))
end

local vnoremaps = function(lhs, rhs, opts)
	map("v", lhs, rhs, vim.tbl_extend("force", { noremap = true, silent = true }, opts or {}))
end

local noremaps = function(lhs, rhs, opts)
	map("", lhs, rhs, vim.tbl_extend("force", { noremap = true, silent = true }, opts or {}))
end

-- Jump to last in stack
nnoremaps("<leader>o", "<C-o>")

-- Write all buffers
nnoremaps("<leader>w", ":wa<cr>")

-- Fold and unfold
nnoremaps("<space>", "za")

-- Always change inner words instead of up to the end
nnoremaps("cw", "ciw")
nnoremaps("cW", "ciW")

-- Disable highlight when <leader><leader> is pressed
noremaps("<leader><leader>", ":noh<cr>")

-- Tmux navigator - either switch Vim panes if present or switch tmux panes
inoremaps("<C-h>", "<C-O>:TmuxNavigateLeft<cr>")
inoremaps("<C-j>", "<C-O>:TmuxNavigateDown<cr>")
inoremaps("<C-k>", "<C-O>:TmuxNavigateUp<cr>")
inoremaps("<C-l>", "<C-O>:TmuxNavigateRight<cr>")

-- Switch between buffers left and with <S-h> and <S-l>
nnoremaps("S-h>", ":BufferPrevious<cr>")
nnoremaps("S-l>", ":BufferNext<cr>")

-- Jump to beginning of line with 0
noremaps("0", "^")

-- Telescope
nnoremaps("<C-p>", function()
	require("telescope.builtin").find_files()
end)
nnoremaps("<C-o>", function()
	require("telescope.builtin").live_grep()
end)

-- Doge
nnoremaps("<leader>b", "<Plug>(doge-generate)")
for _, fn in pairs({ nnoremaps, inoremaps, snoremaps }) do
	fn("<Tab", "<Plug>(doge-jump-forward)")
	fn("<S-Tab", "<Plug>(doge-jump-backward)")
end

-- Don't jump with *
noremaps("*", "<Plug>(asterisk-z*)")
noremaps("#", "<Plug>(asterisk-z#)")
noremaps("g*", "<Plug>(asterisk-gz*)")
noremaps("g#", "<Plug>(asterisk-gz#)")

-- nvim-tree
nnoremaps("<C-t>", ":NvimTreeToggle<CR>")

-- LSP
nnoremaps("<leader>t", function()
	require("trouble").toggle("workspace_diagnostics")
end)
nnoremaps("<leader>e", vim.diagnostic.open_float)
nnoremaps("<leader>D", vim.diagnostic.goto_prev)
nnoremaps("<leader>d", vim.diagnostic.goto_next)
nnoremaps("<leader>q", vim.diagnostic.setloclist)

-- Copilot
local function ask_copilot(target)
	local copilot = require("CopilotChat")
	return function()
		return copilot.ask(vim.fn.input("Ask " .. target), { selection = require("CopilotChat.select")[target] })
	end
end

nnoremaps("<leader>c", ask_copilot("buffer"))
vnoremaps("<leader>c", ask_copilot("visual"))

local lsp_augroup = vim.api.nvim_create_augroup("UserLspConfig", {})
local function lsb_bind(event)
	vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

	local opts = { buffer = event.buf }
	nnoremaps("<leader>G", vim.lsp.buf.declaration, opts)
	nnoremaps("<leader>g", vim.lsp.buf.definition, opts)
	nnoremaps("<leader>r", vim.lsp.buf.references, opts)
	nnoremaps("<leader>i", vim.lsp.buf.implementation, opts)
	nnoremaps("K", vim.lsp.buf.hover, opts)

	local ft = vim.bo[event.buf].filetype

	local sig_helps = {
		["ansible"] = ":AnsibleDocVSplit<cr>",
		["yaml.ansible"] = ":AnsibleDocVSplit<cr>",
		["terraform"] = ":OpenDoc<cr>",
	}
	local sig_help = sig_helps[ft] or vim.lsp.buf.signature_help

	nnoremaps("<leader>s", sig_help, opts)

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

-- Overrides
nnoremaps("q:", "<nop>")
nnoremaps("Q", "<nop>")
nnoremaps("q", "<nop>")
nnoremaps("<leader>q", "<esc>:TroubleClose<cr>:qa<cr>")
nnoremaps("<leader>z", "<esc>:TroubleClose<cr>:bd<cr>")
