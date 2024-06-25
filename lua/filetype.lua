local fts = {
	[".env"] = "env",

	["*.tfvars"] = "terraform-vars",
	["*.tftpl"] = "terraform-tpl",

	["*.yml.j2"] = "yaml.jinja",
	["*.yaml.j2"] = "yaml.jinja",
	["*.json.j2"] = "json.jinja",
	["*.sh.j2"] = "bash.jinja",
	["*.toml.j2"] = "toml.jinja",

	[".env.tpl"] = "env",
	["*.yml.tpl.j2"] = "yaml.jinja",
	["*.yaml.tpl.j2"] = "yaml.jinja",
	["*.json.tpl.j2"] = "json.jinja",
	["*.toml.tpl.j2"] = "toml.jinja",

	["*.yml.tpl"] = "yaml",
	["*.yaml.tpl"] = "yaml",
	["*.json.tpl"] = "json",
	["*.toml.tpl"] = "toml",

	-- Obsolete, leaving for reference
	-- ["*.h"] = function()
	--	local files = vim.fn.glob(vim.fn.expand("%:p:h") .. "/*.ino", false, true)
	--	if #files > 0 then
	--		return "arduino"
	--	end
	--	files = vim.fn.glob(vim.fn.expand("%:p:h") .. "/*.cpp", false, true)
	--	if #files > 0 then
	--		return "cpp"
	--	end
	--	return "c"
	--end,
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
	["terraform"] = {
		shiftwidth = 2,
		tabstop = 2,
		softtabstop = 2,
		colorcolumn = "100",
	},
	["terraform-vars"] = {
		shiftwidth = 2,
		tabstop = 2,
		softtabstop = 2,
		colorcolumn = "100",
	},
}

local ft_augroup = vim.api.nvim_create_augroup("filetype", { clear = true })

for pattern, filetype in pairs(fts) do
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPre", "BufRead" }, {
		group = ft_augroup,
		pattern = pattern,
		callback = function()
			if type(filetype) == "function" then
				vim.bo.filetype = filetype()
			else
				vim.bo.filetype = filetype
			end
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
