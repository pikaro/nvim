local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.clangd,

	cmd = {
		"clangd",
		"--background-index",
		"--suggest-missing-includes",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--header-insertion-decorators",
		"--cross-file-rename",
		"--compile-commands-dir=build",
		"--pch-storage=memory",
		"--completion-style=detailed",
		"--log=verbose",
	},

	options = {
		single_file_support = true,
	},

	capabilities = {
		offsetEncoding = "utf-8",
	},

	filetypes = { "c", "cpp", "arduino" },

	root_dir = function(fname)
		return lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")(fname)
			or lspconfig.util.path.dirname(fname)
	end,
}
