return function(files)
	local strippednames = {}
	for _, file in ipairs(files) do
		table.insert(strippednames, vim.fn.fnamemodify(file, ":t"))
	end
	return strippednames
end
