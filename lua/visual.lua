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
vim.opt.pumheight = 5

-- Switch between two colorschemes when switching windows
vim.api.nvim_set_hl(0, "ActiveWindow", { bg = "#1c1c1c", fg = vim.api.nvim_get_hl_by_name("Normal", true).foreground })
vim.api.nvim_set_hl(
	0,
	"InactiveWindow",
	{ bg = "#262626", fg = vim.api.nvim_get_hl_by_name("Normal", true).foreground }
)

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
