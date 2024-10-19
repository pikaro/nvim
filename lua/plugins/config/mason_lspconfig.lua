return function()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"ansiblels",
			"bashls",
			-- TODO: How to re-add clang-tidy / clang-format config files?
			"clangd",
			"cssls",
			"docker_compose_language_service",
			"dockerls",
			"efm",
			-- TODO: How to correctly resolve includes in CI repo?
			"gitlab_ci_ls",
			"gopls",
			-- FIXME: Does not seem to be doing anything
			"jinja_lsp",
			"jsonls",
			"lua_ls",
			"phpactor",
			"pyright",
			"rust_analyzer",
			"terraformls",
			"texlab",
			-- FIXME: This one is not even loading
			"ts_ls",
			"yamlls",
		},
		automatic_installation = true,
	})
end
