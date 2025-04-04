local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.texlab,
	filetypes = { "tex", "plaintex", "bib" },
	settings = {
		texlab = {
			bibtexFormatter = "texlab",
			build = {
				args = { "--shell-escape", "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				executable = "latexmk",
				forwardSearchAfter = false,
				onSave = true,
			},
			chktex = {
				onEdit = false,
				onOpenAndSave = false,
			},
			diagnosticsDelay = 300,
			formatterLineLength = 80,
			forwardSearch = {
				args = {},
			},
			latexFormatter = "latexindent",
			latexindent = {
				modifyLineBreaks = false,
			},
		},
	},
}
