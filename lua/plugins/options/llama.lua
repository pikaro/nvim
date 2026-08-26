local pidfile = "/tmp/nvim-agent.pid"

if context.system.copilot or not vim.uv.fs_stat(pidfile) then
	return {
		auto_fim = false,
		enable_at_startup = false,
	}
else
	return {
		auto_fim = true,
		enable_at_startup = true,
		endpoint_fim = "http://127.0.0.1:8080/infill",
		endpoint_inst = "http://127.0.0.1:8080/v1/chat/completions",
		keymap_fim_trigger = "<leader>llf",
		keymap_fim_accept_full = "<a-cr>",
		keymap_fim_accept_line = "<a-s-cr>",
		keymap_fim_accept_word = "<a-s-l>",
		keymap_fim_next = "<a-s-j>",
		keymap_fim_prev = "<a-s-k>",
	}
end
