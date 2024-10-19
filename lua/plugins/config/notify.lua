return function()
	require("notify").setup({
		stages = "static",
		timeout = 3000,
		animate = false,
		render = "compact",
	})
end
