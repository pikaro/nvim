local lspconfig = require("lspconfig")

return {
	lsp = "ts_ls",
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
	cmd = { "typescript-language-server", "--stdio" },
	settings = {},
	init_options = {
		hostInfo = "neovim",
	},
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = true
	end,
}
