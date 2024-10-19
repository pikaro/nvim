local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.bashls,
	filetypes = { "bash", "sh" },
}
