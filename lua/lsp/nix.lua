return {
	lsp = "nil_ls",
	settings = {
		["nil"] = {
			formatting = {
				command = { "alejandra" },
			},
			nix = { flake = { autoArchive = true } },
		},
	},
}
