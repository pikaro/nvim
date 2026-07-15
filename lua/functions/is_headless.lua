return function()
	for _, arg in ipairs(vim.v.argv or {}) do
		if arg == "--headless" then
			return true
		end
	end
	return false
end
