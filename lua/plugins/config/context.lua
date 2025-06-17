return function()
	require("treesitter-context").setup({
		enable = true,
		multiwindow = true,
		line_numbers = true,
	})
	vim.api.nvim_set_hl(0, "TreesitterContext", { link = "ColorColumn" })
	vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { link = "Special" })
	vim.api.nvim_set_hl(0, "TreesitterContextBottom", { link = "ColorColumn" })
end
