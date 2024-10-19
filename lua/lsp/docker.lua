local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.dockerls,
	filetypes = { "dockerfile" },
}
