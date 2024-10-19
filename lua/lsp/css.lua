local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.cssls,
	filetypes = { "css", "scss", "less" },
	settings = {
		css = {
			validate = true,
		},
		scss = {
			validate = true,
		},
		less = {
			validate = true,
		},
	},
	options = {
		single_file_support = true,
	},
}
