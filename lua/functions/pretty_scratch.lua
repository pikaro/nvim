return function(data)
	vim.cmd("new")
	local buf = vim.api.nvim_get_current_buf()

	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)

	local current_line = ""
	local line_num = 0

	local processed_data = {}
	local line = {}
	-- Input: { { "string1", "HighlightGroup1" }, { ": "}, { "\n" }, { "string2\n\nstring3\n", "HighlightGroup2" } }
	-- Iterate over each item in the data list

	for _, item in ipairs(data) do
		local text = item[1]
		local hl_group = item[2]

		if not string.match(text, "^\n+$") and string.find(text, "\n") then
			-- Split the text by newline
			local split_text = vim.split(text, "\n", { trimempty = false })
			for _, split in ipairs(split_text) do
				if split ~= "" then
					table.insert(line, { split, hl_group })
				end
				table.insert(processed_data, line)
				line = {}
			end
		elseif string.match(text, "^\n+$") then
			for _ = 1, #text do
				table.insert(processed_data, line)
				line = {}
			end
		else
			-- If the text does not contain a newline, add it to the line list
			table.insert(line, { text, hl_group })
		end
	end

	-- Add the last line if not empty
	if #line > 0 then
		table.insert(processed_data, line)
	end

	-- Output: {
	--           { { "string1", "HighlightGroup1" }, { ": "} },
	--           { { "string2", "HighlightGroup2" } },
	--           {},
	--           { { "string3", "HighlightGroup2" } },
	--         }

	-- Now write the output data to the buffer
	local line_buf = 0
	for line_idx, line_list in ipairs(processed_data) do
		if line_idx > 1 then
			-- Add a new line for each new line of data except the first
			vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "" })
			line_buf = line_buf + 1
		end

		-- Track the column index where the next item should start
		local col_idx = 0

		-- Append each item in the line individually
		for _, item in ipairs(line_list) do
			local text = item[1] -- Get the text from the item

			-- Append text at the current position
			vim.api.nvim_buf_set_text(buf, line_buf, col_idx, line_buf, col_idx, { text })

			if item[2] then
				vim.api.nvim_buf_add_highlight(buf, -1, item[2], line_buf, col_idx, col_idx + #text)
			end

			-- Update the column index for the next item
			col_idx = col_idx + #text
		end
	end

	-- Ensure the buffer is correctly displayed
	vim.api.nvim_command("normal! G")
end
