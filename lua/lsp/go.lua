local downgrade = {
	["UnusedImport"] = vim.diagnostic.severity.WARN,
	["UnusedVar"] = vim.diagnostic.severity.WARN,
	["UnusedParam"] = vim.diagnostic.severity.WARN,
}

local filter_handler = function(err, result, ctx, config)
	if not result then
		return
	end
	local diagnostics = result.diagnostics
	if not diagnostics then
		return
	end
	for _, diagnostic in ipairs(diagnostics) do
		if diagnostic.source == "compiler" then
			local severity = downgrade[diagnostic.code]
			if severity then
				diagnostic.severity = severity
			end
		end
	end
	vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
end

return {
	lsp = "gopls",
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	settings = {
		gopls = {
			-- See efm.lua - wrapped by golines
			gofumpt = false,
			analyses = {
				-- All other analyzers are enabled by default
				unusedparams = true,
				unusedvariable = true,
				unusedwrite = true,
				shadow = true,
				useany = true,
			},
			staticcheck = true,
		},
	},
	diagnostics = {
		severity_sort = true,
		underline = true,
	},
	handlers = {
		["textDocument/publishDiagnostics"] = vim.lsp.with(filter_handler, {}),
	},
}
