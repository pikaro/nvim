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
		diffthis = {
			vertical = true,
			split = "left",
		},
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
			map("n", "==", gs.preview_hunk)
			map("n", "=v", gs.preview_hunk_inline)
			map("n", "=t", function()
				-- local bufs = vim.tbl_filter(function(b)
				-- 	return vim.api.nvim_buf_get_option(b, "filetype") ~= "git"
				-- end, vim.api.nvim_list_bufs())
				gs.setqflist("all")
			end)
			map("n", "[h", gs.prev_hunk)
			map("n", "]h", gs.next_hunk)
		end,
	})
end
