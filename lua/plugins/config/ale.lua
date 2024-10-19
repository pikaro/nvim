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
	-- Handled by LSP
	["c"] = {},
	["cpp"] = {},
	["yaml"] = {},
	["bash"] = {},
	["terraform"] = {},
	["ansible"] = {},
	["python"] = { "ruff" },
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
	["c"] = { "clangtidy", "clang-format" },
	["cpp"] = { "clangtidy", "clang-format" },
	["css"] = { "stylefmt" },
	["dockerfile"] = { "dprint" },
	["go"] = { "gofumpt" },
	["lua"] = { "stylua" },
	["python"] = { "ruff", "ruff_format" },
	["javascript"] = { "prettier-eslint" },
	["json"] = { "prettier" },
	["markdown"] = { "prettier" },
	["scss"] = { "stylefmt" },
}

local clang_all = function(var, value)
	vim.g["ale_c_" .. var] = value
	vim.g["ale_cpp_" .. var] = value
end

clang_all("clangformat_style_option", "file:" .. vim.fn.expand("~/.config/clang-format.yml"))
clang_all("clangtidy_extra_options", "--fix-notes --config-file=" .. vim.fn.expand("~/.config/clang-tidy.yml"))
clang_all("clangtidy_fix_errors", 1)

-- call ale#Set('c_clangformat_options', '--style=file:~/.config/clang-format') from Lua
vim.g.ale_echo_cursor = 0
vim.g.ale_warn_about_trailing_whitespace = 0
vim.b.ale_javascript_prettier_options = "--prose-wrap always"
vim.b.ale_python_pylint_options = "--load-plugins=pylint.extensions.docparams"
vim.g.ale_set_highlights = 0
vim.g.ale_lua_luacheck_options = "--globals vim"

return function() end
