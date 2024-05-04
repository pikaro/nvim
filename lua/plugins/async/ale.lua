vim.g.ale_echo_msg_format = "[%linter%] %s [%severity%]"
vim.g.ale_sign_error = "!"
vim.g.ale_sign_warning = "?"
vim.g.ale_lint_on_text_changed = "always"
vim.g.ale_lint_on_insert_leave = 1
vim.g.ale_sign_column_always = 1
vim.g.ale_sign_priority = 100
vim.g.ale_fix_on_save = 1

vim.g.ale_linters = {
	["dockerfile"] = { "hadolint" },
	["css"] = { "stylelint" },
	["javascript"] = { "eslint" },
	["json"] = { "jsonlint" },
	["lua"] = { "luacheck" },
	["markdown"] = { "markdownlint" },
	["scss"] = { "stylelint" },
	["vim"] = { "vint" },
	["yaml"] = {},
	["bash"] = {},
	["ansible"] = {},
	["python"] = { "ruff" },
	["terraform"] = {},
}

-- Previously used, now covered by LSP
-- 'ansible': ['ansible-lint'],
-- 'python': ['ruff'],
-- 'bash': ['shellcheck'],
-- 'terraform': ['tflint'],
-- 'yaml': ['yamllint'],
-- vim.g.ale_terraform_tflint_options = '--no-module -f json'

-- No YAML fixers work with Gitlab CI :(
vim.g.ale_fixers = {
	["bash"] = { "shfmt" },
	["css"] = { "stylefmt" },
	["dockerfile"] = { "dprint" },
	["lua"] = { "stylua" },
	["python"] = { "ruff", "ruff_format" },
	["javascript"] = { "prettier-eslint" },
	["json"] = { "prettier" },
	["markdown"] = { "prettier" },
	["scss"] = { "stylefmt" },
}

vim.g.ale_echo_cursor = 0
vim.g.ale_warn_about_trailing_whitespace = 0
vim.b.ale_javascript_prettier_options = "--prose-wrap always"
vim.b.ale_python_pylint_options = "--load-plugins=pylint.extensions.docparams"
vim.g.ale_set_highlights = 0
vim.g.ale_lua_luacheck_options = "--globals vim"

return function() end
