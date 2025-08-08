local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.clangd,

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
