return function()
	require("notify").setup({
		timeout = 1000,
		stages = "fade",
		render = "wrapped-compact",
	})
	require("telescope").load_extension("notify")
end
