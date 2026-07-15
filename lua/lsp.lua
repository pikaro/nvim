local function ft_config(language)
	local path = "lsp/" .. language
	local ok, config = pcall(require, path)
	if ok then
		return config
	end
	return nil
end

local default_config = {
	priority = 1,
	underline = false,
}

vim.lsp.log.set_level("ERROR")

local languages = require("functions.strippednames")(require("functions.basenames")(require("functions.ls")("lsp")))

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, language in ipairs(languages) do
	local config = ft_config(language)
	if config then
		local lsp = config.lsp
		local cmd = config.cmd
		local init_options = config.init_options
		local diagnostics = vim.tbl_extend("force", default_config, config.diagnostics or {})
		local filetypes = config.filetypes or { language }
		local root_markers = config.root_markers
		local settings = config.settings or {}
		local lsp_capabilities = vim.tbl_extend("keep", capabilities, config.capabilities or {})
		local handlers = config.handlers or {}

		local on_attach = function(client, bufnr)
			if config.format == false then
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end
			if config.diagnostics then
				local namespace = vim.lsp.diagnostic.get_namespace(client.id, config.uses_pull_diagnostics or false)
				vim.diagnostic.config(diagnostics, namespace)
			end
			if config.on_attach then
				config.on_attach(client, bufnr)
			end
		end

		local options = {
			cmd = cmd,
			init_options = init_options,
			on_attach = on_attach,
			filetypes = filetypes,
			capabilities = lsp_capabilities,
			root_dir = config.root_dir,
			root_markers = root_markers,
			workspace_required = config.workspace_required,
			settings = settings,
			handlers = handlers,
		}
		options = vim.tbl_extend("force", options, config.options or {})

		vim.lsp.config(lsp, options)
		vim.lsp.enable(lsp)
	end
end

vim.lsp.inlay_hint.enable(false)

vim.api.nvim_create_autocmd("LspProgress", {
	callback = function()
		vim.cmd("redrawstatus")
	end,
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✗",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})
