return function()
	if require("functions.is_headless")() then
		-- WARNING: copilot.lua starts a Node language server during setup. Keep this
		-- guard so repeated headless Neovim runs cannot orphan Copilot Node processes.
		return
	end

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
		nes = {
			enabled = false,
			auto_trigger = true,
			keymap = {
				accept_and_goto = false,
				accept = false,
				dismiss = false,
			},
		},
	})

	local status_icons = {
		[""] = "💤",
		normal = "🟢",
		inprogress = "⏳",
		warning = "❗",
		error = "❌",
	}

	require("copilot.status").register_status_notification_handler(function(data)
		local status = string.lower(data.status or "")
		local message = data.message or ""
		local value = status_icons[status] or "🚫"

		if message ~= "" then
			value = value .. " " .. message
		end

		vim.schedule(function()
			vim.g.copilot_status = value
			vim.cmd.redrawstatus()
		end)
	end)
end
