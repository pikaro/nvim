local lsp_status = require("lsp-status")

vim.g.copilot_status = "💤"

local function get_copilot_status()
	return vim.g.copilot_status
end

local function get_arduino_status()
	if vim.bo.filetype ~= "arduino" then
		return ""
	end
	local port = vim.fn["arduino#GetPort"]()
	local line = string.format("[%s]", vim.g.arduino_board)
	if vim.g.arduino_programmer ~= "" then
		line = line .. string.format(" [%s]", vim.g.arduino_programmer)
	end
	if port ~= 0 then
		line = line .. string.format(" (%s:%s)", port, vim.g.arduino_serial_baud)
	end
	return line
end

require("lualine").setup({
	sections = {
		lualine_a = { get_copilot_status, get_arduino_status, "mode" },
		lualine_c = { "filename", lsp_status.status() },
	},
})
