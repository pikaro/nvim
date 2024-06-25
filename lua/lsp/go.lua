local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.gopls,
	filetypes = { "go", "gomod" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}
