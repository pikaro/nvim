local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.ansiblels,
	filetypes = { "yaml.ansible", "ansible" },
	settings = {
		ansible = {
			ansible = {
				path = "ansible",
				useFullyQualifiedCollectionNames = true,
			},
			validation = {
				lint = {
					enabled = true,
					path = "ansible-lint",
					arguments = { "--config", "~/.config/ansible-lint.yml" },
				},
			},
			executionEnvironment = {
				enabled = false,
			},
			python = {
				interpreterPath = "python",
			},
			completion = {
				provideRedirectModules = true,
				provideModuleOptionAliases = true,
			},
		},
	},
}
