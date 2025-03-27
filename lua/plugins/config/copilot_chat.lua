return function()
	require("CopilotChat").setup({
		layout = "vertical",
		clear_chat_on_new_prompt = false,
		mappings = {
			-- Conflicts with Kitty navigation
			-- Not possible to set to nil
			reset = {
				normal = "<C-x>",
				insert = "<C-x>",
			},
		},
	})
end
