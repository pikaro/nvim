return function()
	require("nvim_aider").setup({
		-- Command that executes Aider
		aider_cmd = "aider",
		-- Command line arguments passed to aider
		args = {
			"--no-auto-commits",
			"--pretty",
			"--stream",
		},
		-- Automatically reload buffers changed by Aider (requires vim.o.autoread = true)
		auto_reload = false,
		-- Idle timeout in ms for Aider's output.
		idle_timeout = 5000,
		-- Response timeout in ms for Aider's first output chunk.
		response_timeout = 30000,
		-- Timeout in ms for quick commands.
		quick_idle_timeout = 500,
		-- A list of slash-commands that should have a shorter idle timeout.
		quick_commands = {
			"/add",
			"/drop",
			"/read-only",
			"/ls",
			"/clear",
			"/reset",
			"/undo",
		},
		-- Show 'Processing...' and 'Done' notifications.
		notifications = true,
		-- Theme colors (automatically uses Catppuccin flavor if available)
		theme = {
			user_input_color = "#d65d0e",
			tool_output_color = "#98971a",
			tool_error_color = "#fb4934",
			tool_warning_color = "#fabd2f",
			assistant_output_color = "#ebdbb2",
			completion_menu_color = "#c0caf5",
			completion_menu_bg_color = "#3c3836",
			completion_menu_current_color = "#282828",
			completion_menu_current_bg_color = "#458588",
		},
		-- snacks.picker.layout.Config configuration
		picker_cfg = {
			preset = "vscode",
		},
		-- Other snacks.terminal.Opts options
		config = {
			os = { editPreset = "nvim-remote" },
			gui = { nerdFontsVersion = "3" },
		},
		win = {
			wo = { winbar = "Aider" },
			style = "nvim_aider",
			position = "right",
		},
	})
end
