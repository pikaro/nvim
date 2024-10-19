local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.gitlab_ci_ls,
	filetypes = { "yaml.gitlabci", "gitlabci" },
}
