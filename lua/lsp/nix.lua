local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.nil_ls,
	settings = {
		["nil"] = {
			formatting = {
				command = { "alejandra" },
			},
		},
	},
}
