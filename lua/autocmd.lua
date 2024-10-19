local setup_augroup = vim.api.nvim_create_augroup("global_setup", {})

local function aucmd(event, pattern, callback)
	vim.api.nvim_create_autocmd(event, {
		group = setup_augroup,
		pattern = pattern,
		callback = callback,
	})
end

aucmd({ "BufEnter", "FocusGained", "InsertLeave" }, "*", function()
	local array_has = require("functions.array_has")
	if array_has({ "NvimTree" }, vim.bo.filetype) then
		return
	end
	vim.o.relativenumber = true
end)
aucmd({ "BufLeave", "FocusLost", "InsertEnter" }, "*", function()
	vim.o.relativenumber = false
end)

if vim.fn.has("gui_running") then
	aucmd("InsertEnter", "*", function()
		vim.o.timeoutlen = 0
	end)
	aucmd("InsertLeave", "*", function()
		vim.o.timeoutlen = 1000
	end)
end

aucmd({ "BufWritePost" }, "*.puml", function()
	local filepath = vim.fn.expand("%:p")
	local outputpath = "/tmp/nvim-plantuml-output.png"
	local configpath = vim.fn.expand("~/.config/nvim/include/plantuml.puml")
	local command = string.format("cat %s %s | plantuml -darkmode -tpng -pipe > %s &", configpath, filepath, outputpath)
	vim.fn.system(command)
end)
