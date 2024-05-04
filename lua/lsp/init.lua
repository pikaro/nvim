local function ft_config(language)
	local path = "lsp/" .. language
	local ok, config = pcall(require, path)
	if ok then
		return config
	end
	return nil
end

local default_config = {
	underline = false,
}

local languages = {
	"ansible",
	"javascript",
	"php",
	"python",
	"terraform",
}

local lsp_status = require("lsp-status")
lsp_status.register_progress()

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

for _, language in ipairs(languages) do
	local config = ft_config(language)
	if config then
		local lsp = config.lsp
		local diagnostics = vim.tbl_extend("force", default_config, config.diagnostics or {})
		local filetypes = config.filetypes or { language }
		local settings = config.settings or {}
		local on_attach = config.on_attach
				and function(client, bufnr)
					config.on_attach(client, bufnr)
					lsp_status.on_attach(client, bufnr)
				end
			or lsp_status.on_attach
		vim.diagnostic.config(diagnostics)
		local options = {
			on_attach = on_attach,
			filetypes = filetypes,
			capabilities = capabilities,
			settings = settings,
		}
		lsp.setup(vim.tbl_extend("force", options, config.options or {}))
	end
end

local signs = { Error = "✗", Warn = "", Hint = " ", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.set_log_level("off")
