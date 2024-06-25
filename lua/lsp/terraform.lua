local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.terraformls,
	filetypes = { "terraform", "terraform-vars" },
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			pattern = { "*.tf", "*.tfvars" },
			callback = function()
				vim.lsp.buf.format()
			end,
		})

		require("treesitter-terraform-doc").setup({
			command_name = "OpenDoc",
			url_opener_command = "!open",
			jump_argument = true,
		})
	end,
}
