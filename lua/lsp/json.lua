local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.jsonls,
	filetypes = { "json" },
	init_options = {
		provideFormatter = true,
	},
}
