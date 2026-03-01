return function()
	local cov = require("coverage")

	cov.setup({
		auto_reload = true,
		commands = true,
		highlights = {
			covered = { fg = "#282828" },
		},
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "python",
		callback = function()
			cov.load({ true })
		end,
	})
end
