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
			map("n", "<leader>hw", gs.toggle_word_diff)
			map("n", "<leader>hd", gs.diffthis)
			map("n", "<leader>hB", gs.blame)
			map("n", "<leader>hb", gs.blame_line)
			map("n", "<leader>ha", gs.stage_buffer)
			map("n", "<leader>hA", gs.reset_buffer_index)
			map("n", "<leader>hs", gs.stage_hunk)
			map("n", "<leader>hr", gs.reset_hunk)
			map("n", "<leader>hR", gs.reset_buffer)
			map("n", "<leader>hh", gs.preview_hunk)
			map("n", "<leader>hv", gs.preview_hunk_inline)
			map("n", "<leader>ht", function()
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
