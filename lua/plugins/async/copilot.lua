return function()
	require("copilot").setup({
		suggestion = {
			auto_trigger = true,
			keymap = {
				accept = "<a-cr>",
				accept_line = "<a-s-cr>",
			},
		},
		filetypes = {
			yaml = true,
			json = false,
			markdown = true,
			help = false,
			gitcommit = false,
			gitrebase = false,
			env = false,
			confini = false,
			ini = false,
			arduino = true,
			["."] = false,
		},
	})
end
