return function(...)
	-- Create a new buffer
	vim.cmd("enew")

	-- Get the current buffer number
	local buf = vim.api.nvim_get_current_buf()

	-- Collect the arguments into a single string
	local message = table.concat({ ... }, " ")

	-- Split the message by lines
	local lines = vim.split(message, "\n")

	-- Set the lines in the new buffer
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	-- Set the buffer as not modifiable and remove the filetype
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "filetype", "")

	-- Set a name for the new buffer
	vim.api.nvim_buf_set_name(buf, "[Output]")
end
