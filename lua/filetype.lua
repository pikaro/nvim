vim.filetype.add({
	-- Note: Can use functions returning the type here as well
	filename = {
		[".env"] = "env",
		["env"] = "env",
	},
	extension = {
		["tf"] = "terraform",
		["tfvars"] = "terraform-vars",
		["tftpl"] = "terraform-tpl",
		["puml"] = "plantuml",
		["mount"] = "systemd",
		["service"] = "systemd",
	},
	pattern = {
		["%.env%..*"] = "env",
		["env%..*"] = "env",

		[".*%.tftest%.hcl"] = "terraform-test",

		["docker%-compose%.ya?ml.*%.j2"] = { "yaml.compose.jinja", { priority = 0 } },
		["docker%-compose%.ya?ml.*"] = { "yaml.compose", { priority = -10 } },
		[".*%.ya?ml%.tpl%.j2"] = { "yaml.jinja", { priority = -20 } },
		[".*%.ya?ml%.j2"] = { "yaml.jinja", { priority = -20 } },
		[".*%.j2"] = { "jinja", { priority = -100 } },

		["%.gitlab%-ci%.yml"] = "yaml.gitlabci",
		[".*/gitlab%-ci/.*%.yml"] = "yaml.gitlabci",
		[".*%.ini%.j2"] = "ini.jinja",
		[".*%.json%.j2"] = "json.jinja",
		[".*%.rb%.j2"] = "ruby.jinja",
		[".*%.sh%.j2"] = "bash.jinja",
		[".*%.toml%.j2"] = "toml.jinja",
		[".*%.ini%.tpl%.j2"] = "ini.jinja",
		[".*%.json%.tpl%.j2"] = "json.jinja",
		[".*%.rb%.tpl%.j2"] = "ruby.jinja",
		[".*%.toml%.tpl%.j2"] = "toml.jinja",
		[".*%.xml%.tpl%.j2"] = "xml.jinja",
		[".*%.ya?ml%.tpl"] = "yaml",
		[".*%.json%.tpl"] = "json",
		[".*%.ini%.tpl"] = "ini",
		[".*%.toml%.tpl"] = "toml",
		[".*%.xml%.tpl"] = "xml",

		[".*%.mount%.j2"] = "systemd.jinja",
		[".*%.service%.j2"] = "systemd.jinja",
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
	["helm"] = {
		shiftwidth = 2,
		tabstop = 2,
		softtabstop = 2,
		colorcolumn = "100",
		indentkeys = "!^F,o,O,0#,0},0],0-",
	},
	["json"] = {
		shiftwidth = 2,
		tabstop = 2,
		softtabstop = 2,
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
	["go"] = {
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
