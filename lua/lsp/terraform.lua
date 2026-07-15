return {
	lsp = "tofu_ls",
	filetypes = { "opentofu", "opentofu-vars", "terraform", "terraform-vars", "terraform-test" },
	root_markers = { ".terraform", ".git", ".terraform.lock.hcl", "main.tf", "variables.tf" },
	workspace_required = true,
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
