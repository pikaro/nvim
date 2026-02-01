return function()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"ansiblels",
			"bashls",
			-- "clangd", -- use custom built one
			-- "copilot", -- redundant with copilot.nvim
			"cssls",
			"docker_compose_language_service",
			"dockerls",
			"efm",
			-- TODO: How to correctly resolve includes in CI repo?
			"gitlab_ci_ls",
			"gopls",
			"helm_ls",
			-- FIXME: Does not seem to be doing anything
			"jinja_lsp",
			"jsonls",
			"lua_ls",
			"nil_ls",
			"phpactor",
			"pyright",
			"rust_analyzer",
			"terraformls",
			"texlab",
			"tofu_ls",
			"ts_ls",
			"yamlls",
		},
		automatic_installation = true,
		automatic_enable = false,
	})
end
