return {
	lsp = "tofu_ls",
	filetypes = { "terraform", "terraform-vars", "terraform-test" },
	options = {
		single_file_support = false,
	},
	on_attach = function(client, bufnr)
		require("treesitter-terraform-doc").setup({
			command_name = "OpenDoc",
			url_opener_command = "!open",
			jump_argument = true,
		})
	end,
	diagnostics = {
		severity_sort = true,
		underline = true,
	},
}
