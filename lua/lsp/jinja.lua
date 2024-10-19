local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.jinja_lsp,
	filetypes = { "jinja", "jinja.*", "*.jinja", "yaml.ansible" },
}
