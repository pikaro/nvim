return function()
	require("treesitter-context").setup({
		enable = true,
		multiwindow = true,
		line_numbers = true,
	})
	vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#ff00ff", link = "NONE" })
	vim.api.nvim_set_hl(0, "TreesitterContextBottom", { bg = "#00ff00", link = "NONE" })
end
