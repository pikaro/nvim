local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.yamlls,
	filetypes = { "yaml", "yaml.*" },
}
