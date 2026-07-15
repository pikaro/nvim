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
		["sarif"] = "json",
	},
	pattern = {
		["%.env%..*"] = "env",
		["env%..*"] = "env",

		[".*%.tftest%.hcl"] = "terraform-test",

		-- WARNING: these priorities must beat Neovim's built-in YAML detector;
		-- docker-compose files need exact dotted filetypes for LSP matching.
		["docker%-compose%.ya?ml.*%.j2"] = { "yaml.compose.jinja", { priority = 30 } },
		["docker%-compose%.ya?ml.*"] = { "yaml.compose", { priority = 20 } },
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

local two_space_100 = {
	shiftwidth = 2,
	tabstop = 2,
	softtabstop = 2,
	colorcolumn = "100",
}

local yaml_like = vim.tbl_extend("force", two_space_100, {
	indentkeys = "!^F,o,O,0#,0},0],0-",
})

local two_space = {
	shiftwidth = 2,
	tabstop = 2,
	softtabstop = 2,
}

local ft_options = {
	["yaml"] = yaml_like,
	["helm"] = yaml_like,
	["nix"] = two_space_100,
	["json"] = two_space_100,
	["jinja"] = two_space,
	["python"] = {
		shiftwidth = 4,
		tabstop = 4,
		softtabstop = 4,
		colorcolumn = "100",
	},
	["javascript"] = two_space_100,
	["javascriptreact"] = two_space_100,
	["typescript"] = two_space_100,
	["typescriptreact"] = two_space_100,
	["terraform"] = two_space_100,
	["terraform-vars"] = two_space_100,
	["go"] = {
		colorcolumn = "100",
	},
}

local dotted_ft_options = {
	["javascript.jsx"] = two_space_100,
	["typescript.tsx"] = two_space_100,
	["yaml.compose"] = yaml_like,
	["yaml.compose.jinja"] = yaml_like,
	["yaml.gitlabci"] = yaml_like,
	["yaml.jinja"] = yaml_like,
	["yaml.ansible"] = yaml_like,
}

for filetype, options in pairs(dotted_ft_options) do
	ft_options[filetype] = options
end

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
