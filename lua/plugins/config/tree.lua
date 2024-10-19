return function()
	require("nvim-tree").setup({
		update_focused_file = {
			enable = true,
		},
		disable_netrw = true,
		view = {
			signcolumn = "no",
		},
	})
end
