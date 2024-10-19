return function()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"ansiblels",
			"basedpyright",
			"bashls",
			"clangd",
			"cssls",
			"docker_compose_language_service",
			"denols",
			"dockerls",
			"gitlab_ci_ls",
			"gopls",
			"jinja_lsp",
			"lua_ls",
			"phpactor",
			"rust_analyzer",
			"terraformls",
			"texlab",
		},
		automatic_installation = true,
	})
end
