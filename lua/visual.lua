local vim = vim or {}

local function get_hl(group)
	local status, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)
	if not status then
		return {}
	end
	return hl
end

local function set_hl(group, opts, clear)
	local hl = get_hl(group)

	if clear then
		for key, _ in pairs(hl) do
			hl[key] = nil
		end
	end

	for key, value in pairs(opts) do
		hl[key] = value
	end

	vim.api.nvim_set_hl(0, group, hl)
end

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.g.gruvbox_italic = 1

local status_ok, _ = pcall(vim.cmd, "colorscheme gruvbox")
if not status_ok then
	-- Handle the case where the colorscheme is not installed yet
	vim.notify("colorscheme gruvbox is not installed", vim.log.levels.WARN)
end

-- Highlighting for Lua / Python / Ruby embedded in Vimscript
vim.g.vimsyn_embed = "lPr"

-- Limit the number of autocompletion options
vim.opt.pumheight = 10

local set_hl_for_floating_window = function()
	vim.api.nvim_set_hl(0, "NormalFloat", {
		bg = "#4f4a46",
	})
end

set_hl_for_floating_window()

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	desc = "Avoid overwritten by loading color schemes later",
	callback = set_hl_for_floating_window,
})

-- Switch between two colorschemes when switching windows
set_hl("ActiveWindow", { bg = "#1c1c1c", fg = get_hl("Normal").foreground })
set_hl("InactiveWindow", { bg = "#262626", fg = get_hl("Normal").foreground })

-- LSP
set_hl("DiagnosticUnderlineWarn", { bg = "#3c2a1f", underline = false, undercurl = false })
set_hl("DiagnosticUnderlineError", { bg = "#4c1f1f", underline = false, undercurl = false })

local function update_winhighlight(is_active)
	local hl_group = is_active and "ActiveWindow" or "InactiveWindow"
	vim.api.nvim_win_set_option(0, "winhighlight", "Normal:" .. hl_group .. ",NormalNC:" .. hl_group)
end

vim.api.nvim_create_augroup("WindowHighlights", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
	group = "WindowHighlights",
	pattern = "*",
	callback = function()
		update_winhighlight(true)
	end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost" }, {
	group = "WindowHighlights",
	pattern = "*",
	callback = function()
		update_winhighlight(false)
	end,
})

update_winhighlight(true)
