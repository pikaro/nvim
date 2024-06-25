local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.arduino_language_server,
	cmd = {
		vim.fn.expand("~/.go/bin/arduino-language-server"),
		"-cli-config",
		vim.fn.expand("~/.arduinoIDE/arduino-cli.yaml"),
		"-fqbn",
		"arduino:esp32:nano_nora", --:PinNumbers=byGPIONumber,USBMode=default,PartitionScheme=default",
		"-clangd",
		--"/usr/bin/clangd",
		"/opt/homebrew/Cellar/llvm/18.1.7/bin/clangd",
		"-log",
	},
	options = {
		single_file_support = true,
	},
	filetypes = { "arduino" },
	capabilities = {
		textDocument = {
			semanticTokens = vim.NIL,
		},
		workspace = {
			semanticTokens = vim.NIL,
		},
	},
	on_attach = function()
		print("Arduino")
	end,
	root_dir = function(fname)
		return lspconfig.util.root_pattern("*.ino", "*.cpp", "*.c")(fname) or lspconfig.util.path.dirname(fname)
	end,
	-- settings = {
	-- 	-- ansible = {
	-- 	-- 	ansible = {
	-- 	-- 		path = "ansible",
	-- 	-- 		useFullyQualifiedCollectionNames = true,
	-- 	-- 	},
	-- 	-- 	validation = {
	-- 	-- 		lint = {
	-- 	-- 			enabled = true,
	-- 	-- 			path = "ansible-lint",
	-- 	-- 			arguments = { "--config", "~/.config/ansible-lint.yml" },
	-- 	-- 		},
	-- 	-- 	},
	-- 	-- 	executionEnvironment = {
	-- 	-- 		enabled = false,
	-- 	-- 	},
	-- 	-- 	python = {
	-- 	-- 		interpreterPath = "python",
	-- 	-- 	},
	-- 	-- 	completion = {
	-- 	-- 		provideRedirectModules = true,
	-- 	-- 		provideModuleOptionAliases = true,
	-- 	-- 	},
	-- 	-- },
	-- },
}
