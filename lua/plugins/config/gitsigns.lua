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
		current_line_blame = true,
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end
			map("n", "<leader>hw", gs.toggle_word_diff)
			map("n", "<leader>hd", gs.diffthis)
			map("n", "<leader>hD", gs.toggle_deleted)
		end,
	})
end
