local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.efm,
	init_options = { documentFormatting = true },
	filetypes = { "lua", "dockerfile", "markdown", "go" },
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			lua = { require("efmls-configs.formatters.stylua") },
			dockerfile = { require("efmls-configs.linters.hadolint") },
			markdown = {
				require("efmls-configs.linters.markdownlint"),
				require("efmls-configs.formatters.mdformat"),
			},
			go = {
				{
					formatCommand = string.format(
						-- TODO: This issue says gofumpt . needs to be used, but that causes nonzero return
						-- https://github.com/segmentio/golines/issues/100
						"%s --base-formatter=gofumpt --no-reformat-tags",
						require("efmls-configs.fs").executable("golines")
					),
					formatStdin = true,
				},
			},
		},
	},
}
