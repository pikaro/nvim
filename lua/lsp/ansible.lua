local function root_dir(bufnr, on_dir)
	local filename = vim.api.nvim_buf_get_name(bufnr)
	if filename == "" then
		return
	end

	local root = vim.fs.root(bufnr, {
		"ansible.cfg",
		".ansible-lint",
		".ansible-lint.yml",
		".ansible-lint.yaml",
		"galaxy.yml",
	})

	if not root then
		root = filename:match("^(.*)/ansible/")
		if root then
			root = root .. "/ansible"
		end
	end

	if not root then
		root = filename:match("^(.*)/roles/[^/]+/")
			or filename:match("^(.*)/playbooks/")
			or filename:match("^(.*)/group_vars/")
			or filename:match("^(.*)/host_vars/")
	end

	if not root then
		local cwd = vim.uv.cwd()
		if cwd and filename:sub(1, #cwd + 1) == cwd .. "/" then
			root = cwd
		end
	end

	root = root or vim.fs.root(bufnr, { ".git" })
	if root then
		on_dir(root)
	end
end

return {
	lsp = "ansiblels",
	filetypes = { "yaml.ansible", "ansible" },
	root_dir = root_dir,
	settings = {
		ansible = {
			ansible = {
				path = "ansible",
				useFullyQualifiedCollectionNames = true,
			},
			validation = {
				enabled = true,
				lint = {
					enabled = true,
					path = "ansible-lint",
				},
			},
			executionEnvironment = {
				enabled = false,
			},
			python = {
				interpreterPath = "python3.12",
			},
			completion = {
				provideRedirectModules = true,
				provideModuleOptionAliases = true,
			},
		},
	},
}
