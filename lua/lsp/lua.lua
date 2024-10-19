local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.lua_ls,
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = {
					"?.lua",
					"?/init.lua",
				},
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
					vim.env.VIMRUNTIME .. "/lua",
				},
			},
			format = {
				enable = false,
			},
		},
	},
}
