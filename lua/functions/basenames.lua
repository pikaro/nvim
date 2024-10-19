return function(files)
	local basenames = {}
	for _, file in ipairs(files) do
		table.insert(basenames, vim.fn.fnamemodify(file, ":r"))
	end
	return basenames
end
