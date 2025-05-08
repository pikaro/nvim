return function()
	require("copilot").setup({
		suggestion = {
			auto_trigger = true,
			keymap = {
				accept = "<a-cr>",
				accept_line = "<a-s-cr>",
				accept_word = "<a-s-l>",
				next = "<a-s-j>",
				prev = "<a-s-k>",
				dismiss = "<a-s-h>",
			},
		},
		copilot_model = "gpt-4o-copilot",
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
