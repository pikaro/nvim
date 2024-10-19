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
				enabled = true,
				lint = {
					enabled = true,
					path = "ansible-lint",
					arguments = "--config ~/.config/ansible-lint.yml",
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
