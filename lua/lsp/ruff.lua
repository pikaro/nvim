vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if client.name == "ruff" then
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end
	end,
	desc = "LSP: Disable hover capability from Ruff",
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.py",
	group = vim.api.nvim_create_augroup("ruff_fix_all_on_save", { clear = true }),
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "ruff" })
		if #clients == 0 then
			return
		end

		local client = clients[1]
		local encoding = client.offset_encoding or "utf-16"
		local params = vim.lsp.util.make_range_params(0, encoding)
		params.context = {
			only = { "source.fixAll.ruff" },
			diagnostics = {},
		}

		local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
		for _, res in pairs(result or {}) do
			for _, action in pairs(res.result or {}) do
				-- resolve the action if needed
				if not action.edit and action.kind then
					local resolved = client.request_sync("codeAction/resolve", action, 1000, bufnr)
					if resolved and resolved.result then
						action = resolved.result
					end
				end
				if action.edit then
					vim.lsp.util.apply_workspace_edit(action.edit, encoding)
				elseif action.command then
					vim.lsp.buf.execute_command(action.command)
				end
			end
		end
	end,
})

return {
	lsp = "ruff",
	filetypes = { "python" },
	diagnostics = {
		severity_sort = true,
		underline = true,
		virtual_text = {
			prefix = "",
		},
		signs = {
			severity = { min = vim.diagnostic.severity.INFO },
		},
	},
	uses_pull_diagnostics = true,
}
