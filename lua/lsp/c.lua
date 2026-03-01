local lspconfig = require("lspconfig")

local function find_root(fname)
	local cwd = nil
	if not fname or fname == "" then
		cwd = vim.uv.cwd()
	end
	return lspconfig.util.root_pattern(".clangd", "compile_commands.json", "compile_flags.txt", ".git")(fname or cwd)
		or lspconfig.util.path.dirname(fname or cwd)
end

return {
	lsp = "clangd",

	cmd = function(dispatchers, config)
		local uv = vim.uv or vim.loop
		local join = vim.fs.joinpath

		local root = assert(config.root_dir or uv.cwd(), "no root_dir computed")

		local local_bin = join(root, "bin", "clangd")
		local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/clangd"
		local exe = (uv.fs_stat(local_bin) and local_bin) or mason_bin
		assert(uv.fs_stat(exe), "clangd not found: " .. exe)

		local extra = { cwd = root }

		return vim.lsp.rpc.start({ exe }, dispatchers, extra)
	end,

	options = {
		single_file_support = true,
	},

	capabilities = {
		offsetEncoding = "utf-8",
	},

	filetypes = { "c", "cpp", "arduino" },

	root_dir = function(bufnr, on_dir)
		local uv = vim.uv
		local fname = vim.api.nvim_buf_get_name(bufnr)

		local root = find_root(fname)

		if fname:find(vim.fn.expand("~/.platformio/packages/"), 1, true) then
			for _, client in ipairs(vim.lsp.get_clients({ name = "clangd" })) do
				if client.config and client.config.root_dir then
					root = client.config.root_dir
					break
				end
			end
		end

		on_dir(root or uv.cwd())
	end,
}
