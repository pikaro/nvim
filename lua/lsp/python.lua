local root_markers = {
	"pyrightconfig.json",
	"pyproject.toml",
	"setup.py",
	"setup.cfg",
	"requirements.txt",
	"Pipfile",
	".git",
	"compile_commands.json",
	"package.json",
}

return {
	lsp = "pyright",
	root_markers = root_markers,
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
				indexing = true,
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
