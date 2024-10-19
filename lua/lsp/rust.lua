local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.rust_analyzer,
	filetypes = { "rust" },
}
