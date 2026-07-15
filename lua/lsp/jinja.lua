return {
	lsp = "jinja_lsp",
	-- WARNING: LSP filetypes are exact strings in Neovim 0.12; keep the concrete
	-- dotted template filetypes instead of wildcard-style entries like "*.jinja".
	filetypes = {
		"jinja",
		"bash.jinja",
		"ini.jinja",
		"json.jinja",
		"ruby.jinja",
		"systemd.jinja",
		"toml.jinja",
		"xml.jinja",
		"yaml.compose.jinja",
		"yaml.jinja",
		"yaml.ansible",
	},
}
