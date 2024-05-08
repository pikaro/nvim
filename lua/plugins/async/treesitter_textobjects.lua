return function()
	require("nvim-treesitter.configs").setup({
		textobjects = {
			select = {
				enable = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["aF"] = "@function.outer",
					["iF"] = "@function.inner",
					["ac"] = "@comment.outer",
					["ic"] = "@comment.inner",
					["al"] = "@loop.outer",
					["il"] = "@loop.inner",
					["ab"] = "@block.outer",
					["ib"] = "@block.inner",
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["ii"] = "@conditional.inner",
					["ai"] = "@conditional.outer",
				},
			},
			lsp_interop = {
				enable = true,
				peek_definition_code = {
					["<leader>af"] = "@function.outer",
					["<leader>aF"] = "@class.outer",
				},
			},
		},
	})
end
