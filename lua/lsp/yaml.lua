return {
	lsp = "yamlls",
	-- WARNING: LSP filetypes are exact strings in Neovim 0.12; "yaml.*" does not match dotted YAML filetypes.
	filetypes = { "yaml", "yaml.jinja" },
}
