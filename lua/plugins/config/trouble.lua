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

return function()
	require("trouble").setup({
		auto_preview = false,
		auto_fold = false,
		use_diagnostic_signs = true,
		severity = { min = vim.diagnostic.severity.INFO },
	})
end
