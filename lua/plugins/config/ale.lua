vim.g.ale_echo_msg_format = "[%linter%] %s [%severity%]"
vim.g.ale_sign_error = "!"
vim.g.ale_sign_warning = "?"
vim.g.ale_lint_on_text_changed = "always"
vim.g.ale_lint_on_insert_leave = 1
vim.g.ale_sign_column_always = 1
vim.g.ale_sign_priority = 100
vim.g.ale_fix_on_save = 1

vim.g.ale_linters = {
	["dockerfile"] = {},
	["css"] = {},
	["javascript"] = {},
	["json"] = {},
	["lua"] = {},
	["markdown"] = {},
	["scss"] = {},
	["vim"] = {},
	["c"] = {},
	["cpp"] = {},
	["yaml"] = {},
	["bash"] = {},
	["terraform"] = {},
	["ansible"] = {},
	["python"] = { "ruff" },
	["sh"] = {},
	["go"] = {},
}

vim.g.ale_fixers = {
	["bash"] = {},
	["sh"] = {},
	["c"] = {},
	["cpp"] = {},
	["css"] = {},
	["dockerfile"] = {},
	["go"] = {},
	["lua"] = {},
	-- TODO: Due to the implementation of isort in ruff-lint instead of
	--       formatting, neither basedpyright nor efm are able to fix
	--       imports.
	["python"] = { "ruff", "ruff_format" },
	["javascript"] = {},
	["json"] = {},
	["markdown"] = {},
	["scss"] = {},
}

vim.g.ale_echo_cursor = 0
vim.g.ale_warn_about_trailing_whitespace = 0
vim.g.ale_set_highlights = 0

vim.g.ale_python_ruff_options = "--force-exclude"
vim.g.ale_python_ruff_format_options = "--force-exclude"

return function() end
