-- Jump to the next item in the quickfix list and close the quickfix window.
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local bufnr = vim.fn.bufnr("%")
		vim.keymap.set("n", "<cr>", function()
			vim.api.nvim_command([[execute "normal! \<cr>"]])
			vim.api.nvim_command(bufnr .. "bd")
		end, { buffer = bufnr })
	end,
	pattern = "qf",
})

local re_blacklist = {
	'^Type of ".*" is ".*"$',
}

return function()
	require("trouble").setup({
		auto_preview = false,
		auto_fold = false,
		use_diagnostic_signs = true,
		modes = {
			cascade = {
				mode = "diagnostics", -- inherit from diagnostics mode
				filter = function(items)
					local severity = vim.diagnostic.severity.INFO
					for _, item in ipairs(items) do
						severity = math.min(severity, item.severity)
					end
					return vim.tbl_filter(function(item)
						-- Filter out items that match the blacklist regex
						for _, pattern in ipairs(re_blacklist) do
							if string.match(item.message, pattern) then
								return false
							end
						end
						return item.severity == severity
					end, items)
				end,
			},
		},
	})
end
