local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.clangd,

	cmd = function(dispatchers, config)
		local uv = vim.uv or vim.loop
		local join = vim.fs.joinpath

		local root = assert(config.root_dir or uv.cwd(), "no root_dir computed")

		local local_bin = join(root, "bin", "clangd")
		local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/clangd"
		local exe = (uv.fs_stat(local_bin) and local_bin) or mason_bin
		assert(uv.fs_stat(exe), "clangd not found: " .. exe)

		local argv = { exe, "--compile-commands-dir=" .. root }

		local extra = { cwd = root }

		return vim.lsp.rpc.start(argv, dispatchers, extra)
	end,

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
