local function clean_extra_spaces(event)
	if not vim.api.nvim_get_option_value("modifiable", { buf = event.buf }) then
		return
	end

	local old_query = vim.fn.getreg("/")

	vim.api.nvim_buf_call(event.buf, function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd("%s/\\s\\+$//e")
		vim.fn.setpos(".", save_cursor)
	end)

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
