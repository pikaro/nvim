local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.pyright,
	options = {
		single_file_support = true,
	},
	settings = {
		pyright = {
			disableLanguageServices = false,
			disableOrganizeImports = true,
		},
		python = {
			workspaceSymbols = { enabled = true },
			analysis = {
				autoImportCompletions = true,
				autoSearchPaths = true,
				diagnosticMode = "workspace", -- openFilesOnly, workspace
				typeCheckingMode = "standard", -- off, basic, standard, strict
				useLibraryCodeForTypes = true,
				-- stubPath = ".",
			},
		},
	},
	diagnostics = {
		severity_sort = true,
		underline = true,
		virtual_text = {
			severity = { min = vim.diagnostic.severity.INFO },
			prefix = "",
		},
		signs = {
			severity = { min = vim.diagnostic.severity.INFO },
		},
	},
}
