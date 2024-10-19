local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.efm,
	init_options = { documentFormatting = true },
	filetypes = { "lua", "dockerfile", "markdown" },
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			lua = { require("efmls-configs.formatters.stylua") },
			dockerfile = { require("efmls-configs.linters.hadolint") },
			markdown = {
				require("efmls-configs.linters.markdownlint"),
				require("efmls-configs.formatters.mdformat"),
			},
		},
	},
}
