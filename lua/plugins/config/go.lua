return function()
	require("go").setup({
		diagnostic = false,
		null_ls = {},
		-- gocoverage_sign = "|",
	})
end
