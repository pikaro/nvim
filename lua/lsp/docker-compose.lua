local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.docker_compose_language_service,
	filetypes = { "compose", "yaml.compose" },
}
