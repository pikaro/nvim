local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.tsserver,
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}
