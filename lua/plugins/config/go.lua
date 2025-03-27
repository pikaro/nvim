return function()
	require("go").setup({
		diagnostic = false,
		null_ls = false,
		-- gocoverage_sign = "|",
	})
end
