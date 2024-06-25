local map = vim.keymap.set

local nnoremaps = function(lhs, rhs, opts)
	map("n", lhs, rhs, vim.tbl_extend("force", { noremap = true, silent = true }, opts or {}))
end

local inoremaps = function(lhs, rhs, opts)
	map("i", lhs, rhs, vim.tbl_extend("force", { noremap = true, silent = true }, opts or {}))
end

local snoremaps = function(lhs, rhs, opts)
	map("s", lhs, rhs, vim.tbl_extend("force", { noremap = true, silent = true }, opts or {}))
end

local vnoremaps = function(lhs, rhs, opts)
	map("v", lhs, rhs, vim.tbl_extend("force", { noremap = true, silent = true }, opts or {}))
end

local noremaps = function(lhs, rhs, opts)
	map("", lhs, rhs, vim.tbl_extend("force", { noremap = true, silent = true }, opts or {}))
end

return {
	nnoremaps = nnoremaps,
	inoremaps = inoremaps,
	snoremaps = snoremaps,
	vnoremaps = vnoremaps,
	noremaps = noremaps,
}
