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
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	cmd = { "typescript-language-server", "--stdio" },
	settings = {},
	init_options = {
		hostInfo = "neovim",
	},
}
