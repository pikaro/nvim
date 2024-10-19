vim.filetype.add({
	-- Note: Can use functions returning the type here as well
	filename = {
		[".env"] = "env",
		["env"] = "env",
	},
	extension = {
		["tfvars"] = "terraform-vars",
		["tftpl"] = "terraform-tpl",
		["puml"] = "plantuml",
	},
	pattern = {
		["%.env%..*"] = "env",
		["env%..*"] = "env",
		[".*%.yml%.j2"] = "yaml.jinja",
		[".*%.yaml%.j2"] = "yaml.jinja",
		[".*%.ini%.j2"] = "ini.jinja",
		[".*%.json%.j2"] = "json.jinja",
		[".*%.rb%.j2"] = "ruby.jinja",
		[".*%.sh%.j2"] = "bash.jinja",
		[".*%.toml%.j2"] = "toml.jinja",
		[".*%.yml%.tpl%.j2"] = "yaml.jinja",
		[".*%.yaml%.tpl%.j2"] = "yaml.jinja",
		[".*%.ini%.tpl%.j2"] = "ini.jinja",
		[".*%.json%.tpl%.j2"] = "json.jinja",
		[".*%.rb%.tpl%.j2"] = "ruby.jinja",
		[".*%.toml%.tpl%.j2"] = "toml.jinja",
		[".*%.xml%.tpl%.j2"] = "xml.jinja",
		[".*%.yml%.tpl"] = "yaml",
		[".*%.yaml%.tpl"] = "yaml",
		[".*%.json%.tpl"] = "json",
		[".*%.ini%.tpl"] = "ini",
		[".*%.toml%.tpl"] = "toml",
		[".*%.xml%.tpl"] = "xml",
	},
})

local ft_options = {
	["yaml"] = {
		shiftwidth = 2,
		tabstop = 2,
		softtabstop = 2,
		colorcolumn = "100",
		indentkeys = "!^F,o,O,0#,0},0],0-",
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

local ft_augroup = vim.api.nvim_create_augroup("filetype_options", { clear = true })
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
