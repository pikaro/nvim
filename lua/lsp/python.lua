return {
	lsp = "pyright",
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
				reportShadowedImport = "warning",
				reportMissingSuperCall = false,
				reportUninitializedInstanceVariable = "warning",
				reportPropertyTypeMismatch = "warning",
				reportUnusedCallResult = "warning",
				reportUnusedImport = "information",
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
