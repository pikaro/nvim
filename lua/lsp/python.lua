local lspconfig = require("lspconfig")

local root_files = {
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
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local root = lspconfig.util.root_pattern(unpack(root_files))(fname)
		on_dir(root or lspconfig.util.path.dirname(fname))
	end,
}
