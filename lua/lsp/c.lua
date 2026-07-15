local root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt", ".git" }

local function find_root(bufnr, fname)
	local root = vim.fs.root(bufnr, root_markers)
	if root then
		return root
	end
	if fname and fname ~= "" then
		return vim.fs.dirname(fname)
	end
	return vim.uv.cwd()
end

return {
	lsp = "clangd",

	cmd = function(dispatchers, config)
		local uv = vim.uv
		local join = vim.fs.joinpath

		local root = assert(config.root_dir or uv.cwd(), "no root_dir computed")

		local local_bin = join(root, "bin", "clangd")
		local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/clangd"
		local exe = (uv.fs_stat(local_bin) and local_bin) or mason_bin
		assert(uv.fs_stat(exe), "clangd not found: " .. exe)

		local extra = { cwd = root }

		return vim.lsp.rpc.start({ exe }, dispatchers, extra)
	end,

	settings = {
		clangd = {
			inlayHints = {
				Enabled = false,
				ParameterNames = true,
				DeducedTypes = true,
				Designators = true,
			},
		},
	},

	capabilities = {
		offsetEncoding = "utf-8",
	},

	filetypes = { "c", "cpp", "arduino" },

	root_dir = function(bufnr, on_dir)
		local uv = vim.uv
		local fname = vim.api.nvim_buf_get_name(bufnr)

		local root = find_root(bufnr, fname)

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
