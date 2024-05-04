local fts = {
	["*.tfvars"] = "terraform-vars",
	["*.tftpl"] = "terraform-tpl",
	[".env"] = "env",
	["*.yml.j2"] = "yaml.jinja",
	["*.json.j2"] = "json.jinja",
}

local ft_options = {
	["yaml"] = {
		shiftwidth = 2,
		tabstop = 2,
		softtabstop = 2,
		indentkeys = "-0#",
		colorcolumn = "100",
	},
	["jinja"] = {
		shiftwidth = 2,
		tabstop = 2,
		softtabstop = 2,
	},
	["python"] = {
		shiftwidth = 4,
		tabstop = 4,
		softtabstop = 4,
		colorcolumn = "100",
	},
	["javascript"] = {
		shiftwidth = 2,
		tabstop = 2,
		softtabstop = 2,
		colorcolumn = "100",
	},
}

local ft_augroup = vim.api.nvim_create_augroup("filetype", { clear = true })

for pattern, filetype in pairs(fts) do
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		group = ft_augroup,
		pattern = pattern,
		callback = function()
			vim.opt_local.filetype = filetype
		end,
	})
end

for filetype, _ in pairs(ft_options) do
	vim.api.nvim_create_autocmd({ "FileType" }, {
		group = ft_augroup,
		pattern = filetype,
		callback = function()
			for option, value in pairs(ft_options[filetype]) do
				vim.opt_local[option] = value
			end
		end,
	})
end
