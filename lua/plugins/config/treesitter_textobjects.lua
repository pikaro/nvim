return function()
	require("nvim-treesitter.configs").setup({
		textobjects = {
			select = {
				enable = true,
				keymaps = {
					["if"] = "@function.inner",
					["ic"] = "@comment.inner",
					["il"] = "@loop.inner",
					["ib"] = "@block.inner",
					["ia"] = "@parameter.inner",
					["ii"] = "@conditional.inner",
					["is"] = "@scope.local",
					["of"] = "@function.outer",
					["oc"] = "@comment.outer",
					["ol"] = "@loop.outer",
					["ob"] = "@block.outer",
					["oa"] = "@parameter.outer",
					["oi"] = "@conditional.outer",
					["os"] = "@scope.outer",
				},
			},
			move = {
				enable = true,
				set_jumps = false, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]f"] = "@function.outer",
					["]l"] = "@loop.outer", -- { query = { "@loop.inner", "@loop.outer" } },
					["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
					["]b"] = "@block.outer",
					["]c"] = "@conditional.outer",
					["]p"] = "@parameter.outer",
				},
				goto_next_end = {
					["]F"] = "@function.outer",
					["]L"] = "@loop.outer",
					["]S"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
					["]B"] = "@block.outer",
					["]C"] = "@conditional.outer",
					["]P"] = "@parameter.outer",
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[l"] = "@loop.outer",
					["[s"] = { query = "@local.scope", query_group = "locals", desc = "Previous scope" },
					["[b"] = "@block.outer",
					["[c"] = "@conditional.outer",
					["[p"] = "@parameter.outer",
				},
				goto_previous_end = {
					["[F"] = "@function.outer",
					["[L"] = "@loop.outer",
					["[S"] = { query = "@local.scope", query_group = "locals", desc = "Previous scope" },
					["[B"] = "@block.outer",
					["[C"] = "@conditional.outer",
					["[P"] = "@parameter.outer",
				},
				-- Below will go to either the start or the end, whichever is closer.
				-- Use if you want more granular movements
				-- Make it even more gradual by adding multiple queries and regex.
				-- goto_next = {
				-- 	["]d"] = "@conditional.outer",
				-- },
				-- goto_previous = {
				-- 	["[d"] = "@conditional.outer",
				-- },
			},
			-- lsp_interop = {
			-- 	enable = true,
			-- 	peek_definition_code = {
			-- 		["<leader>af"] = "@function.outer",
			-- 		["<leader>aF"] = "@class.outer",
			-- 	},
			-- },
		},
	})
end
