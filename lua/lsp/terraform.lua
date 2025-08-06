local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.terraformls,
	filetypes = { "terraform", "terraform-vars", "terraform-test" },
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
