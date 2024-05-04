local setup_augroup = vim.api.nvim_create_augroup("global_setup", {})

local function aucmd(event, pattern, callback)
	vim.api.nvim_create_autocmd(event, {
		group = setup_augroup,
		pattern = pattern,
		callback = callback,
	})
end

aucmd({ "BufEnter", "FocusGained", "InsertLeave" }, "*", function()
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
