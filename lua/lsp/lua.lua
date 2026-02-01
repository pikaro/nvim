return {
	lsp = "lua_ls",
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
			hint = {
				enable = true,
				paramName = "All",
				paramType = true,
				arrayIndex = "Disable",
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
			telemetry = {
				enable = false,
			},
		},
	},
}
