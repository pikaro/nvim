return {
	lsp = "docker_compose_language_service",
	-- WARNING: LSP filetypes are exact strings in Neovim 0.12; wildcard-style entries do not match.
	filetypes = { "compose", "yaml.compose", "yaml.compose.jinja" },
}
