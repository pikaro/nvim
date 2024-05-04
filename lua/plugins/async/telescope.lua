return function()
	local telescope_actions = require("telescope.actions")
	require("telescope").setup({
		defaults = {
			mappings = {
				i = {
					["<esc>"] = telescope_actions.close,
					["<C-Down>"] = telescope_actions.cycle_history_next,
					["<C-Up>"] = telescope_actions.cycle_history_prev,
				},
			},
			file_ignore_patterns = { "node_modules/*", ".venv/*", "venv/*", "__pycache__/*" },
		},
	})
end
