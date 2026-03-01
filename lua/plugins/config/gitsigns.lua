return function()
	require("gitsigns").setup({
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "-" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		numhl = true,
		-- Causes issues with diagnostics from LSP
		current_line_blame = false,
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end
			map("n", "=w", gs.toggle_word_diff)
			map("n", "=d", gs.diffthis)
			map("n", "=B", gs.blame)
			map("n", "=b", gs.blame_line)
			map("n", "=a", gs.stage_buffer)
			map("n", "=A", gs.reset_buffer_index)
			map("n", "=s", gs.stage_hunk)
			map("n", "=r", gs.reset_hunk)
			map("n", "=R", gs.reset_buffer)
			map("n", "=v", gs.preview_hunk)
			map("n", "[h", gs.prev_hunk)
			map("n", "]h", gs.next_hunk)
		end,
	})
end
