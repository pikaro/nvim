local function clean_extra_spaces()
	local save_cursor = vim.fn.getpos(".")
	local old_query = vim.fn.getreg("/")

	vim.cmd("%s/\\s\\+$//e")

	vim.fn.setpos(".", save_cursor)
	vim.fn.setreg("/", old_query)
end

local function jump_to_last_edit()
	if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
		vim.cmd('normal! g`"')
	end
end

local group = vim.api.nvim_create_augroup("cleanup", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" }, { group = group, pattern = "*", callback = clean_extra_spaces })
vim.api.nvim_create_autocmd({ "BufReadPost" }, { group = group, pattern = "*", callback = jump_to_last_edit })
