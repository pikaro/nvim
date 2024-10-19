local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.denols,
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}
