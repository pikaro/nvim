local lsp_status = require("lsp-status")

vim.g.copilot_status = "💤"

local function get_copilot_status()
	return vim.g.copilot_status
end

require("lualine").setup({
	sections = {
		lualine_a = { get_copilot_status, "mode" },
		lualine_c = { "filename", lsp_status.status() },
	},
})
