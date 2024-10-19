return function(path)
	local config_home = vim.fn.stdpath("config")
	local dir = config_home .. "/lua/" .. path .. "/*"
	return vim.split(vim.fn.glob(dir), "\n", { trimempty = true })
end
