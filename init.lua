require("lazy_plugins")
require("general")
require("plugins.sync")
require("plugins.misc")
require("filetype")
require("keybinds")
require("cleanup")
require("lsp")
require("autocmd")
require("commands")
require("visual")

local function source_if_exists(filepath)
	local expanded = vim.fn.expand(filepath)
	local file = io.open(expanded, "r")
	if file then
		file:close()
		if string.sub(expanded, -4) == ".lua" then
			dofile(expanded)
		else
			vim.cmd("source " .. expanded)
		end
	end
end

source_if_exists("~/.vimrc.local")
source_if_exists("~/.vimrc.local.lua")
