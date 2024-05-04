require("nvim-tree").setup()

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"dockerfile",
		"go",
		"hcl",
		"hcl",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"regex",
		"terraform",
		"vim",
		"vimdoc",
		"yaml",
	},

	-- Install parsers synchronously
	sync_install = false,
	auto_install = true,
	ignore_install = {},

	highlight = {
		enable = true,
		disable = {},
		-- Too slow
		additional_vim_regex_highlighting = false,
	},
})

-- Add more with :Inspect on the current word
vim.api.nvim_set_hl(0, "@variable.parameter.python", { link = "GruvboxFg3" })
vim.api.nvim_set_hl(0, "@string.documentation.python", { link = "GruvboxGray" })
vim.api.nvim_set_hl(0, "@function.method.python", { link = "GruvboxFg0" })
vim.api.nvim_set_hl(0, "@function.method.call.python", { link = "GruvboxFg1" })
vim.api.nvim_set_hl(0, "@function.call.python", { link = "GruvboxFg1" })
vim.api.nvim_set_hl(0, "@lsp.type.class.yaml.ansible", { link = "GruvboxAquaBold" })
vim.api.nvim_set_hl(0, "@lsp.type.keyword.yaml.ansible", { link = "GruvboxBlue" })
vim.api.nvim_set_hl(0, "@lsp.type.method.yaml.ansible", { link = "GruvboxFg1" })
