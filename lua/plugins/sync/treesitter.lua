require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"arduino",
		"bash",
		"c",
		"cpp",
		"dockerfile",
		"go",
		"hcl",
		"hcl",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"query",
		"regex",
		"scheme",
		"terraform",
		"vim",
		"vimdoc",
		"yaml",
	},

	-- Install parsers synchronously
	sync_install = false,
	auto_install = true,
	ignore_install = {},

	highlight = {
		enable = true,
		disable = {},
		-- Too slow
		additional_vim_regex_highlighting = false,
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<cr>",
			node_incremental = "<cr>",
			scope_incremental = "gc",
			node_decremental = "gm",
		},
	},

	indent = {
		enable = true,
	},
})

local query = require("vim.treesitter.query")
query.add_directive("vim-match-offset!", require("treesitter.directives.vim_match_offset"), { all = true })

local parsers = require("nvim-treesitter.parsers")
local parser_config = parsers.get_parser_configs()
parser_config.jinja = {
	install_info = {
		url = "https://github.com/dbt-labs/tree-sitter-jinja2",
		files = { "src/parser.c" },
		branch = "main",
		generate_requires_npm = true,
		requires_generate_from_grammar = true,
	},
}
vim.treesitter.language.register("jinja", "jinja")

local function read_file(path)
	local file = io.open(path, "r")
	if not file then
		return
	end
	local content = file:read("*a")
	file:close()
	return content
end

local function get_predefined(parser, kind)
	local query_path = "queries/" .. parser .. "/" .. kind .. ".scm"
	local predefined_path = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/" .. query_path
	local custom_path = vim.fn.stdpath("config") .. "/" .. query_path
	local after_path = vim.fn.stdpath("config") .. "/after/" .. query_path
	local parser_queries = read_file(custom_path) or read_file(predefined_path)
	parser_queries = parser_queries .. "\n" .. (read_file(after_path) or "")
	return parser_queries
end

local function get_languages()
	return string.match(vim.bo.filetype, "^([^.]+)%.([^.]+)$")
end

local function get_extended(language, kind)
	local config_path = vim.fn.stdpath("config")
	local path = config_path .. "/after/queries/" .. language .. "/" .. kind .. ".scm"
	return read_file(path)
end

local function extend_queries(parser, language)
	if not parser or not language then
		return
	end
	local kinds = { "highlights", "injections" }
	for _, kind in ipairs(kinds) do
		local predefined = get_predefined(parser, kind) or ""
		local extended = get_extended(language, kind)
		if extended then
			query.set(parser, kind, predefined .. "\n" .. extended)
		end
	end
end

local treesitter_augroup = vim.api.nvim_create_augroup("treesitter", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	group = treesitter_augroup,
	pattern = "*",
	callback = function()
		extend_queries(get_languages())
	end,
})

local function hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

local gruv = require("gruvbox").palette

-- Add more with :Inspect on the current word
hl("@variable.parameter.python", { link = "GruvboxFg3" })
hl("@string.documentation.python", { link = "GruvboxGray" })
hl("@function.method.python", { link = "GruvboxFg0" })
hl("@function.method.call.python", { link = "GruvboxFg1" })
hl("@function.call.python", { link = "GruvboxFg1" })

-- Remove default string highlights because it italicizes map keys and plain text
hl("@string.string_scalar.yaml", { link = nil })
hl("@string.block_scalar.yaml", { link = nil })

hl("@lsp.type.class.yaml.ansible", { link = "GruvboxAquaBold" })

hl("@lsp.type.keyword.yaml.ansible", { link = "GruvboxBlue" })
hl("@lsp.type.property.yaml.ansible", { link = "GruvboxAqua" })
hl("@lsp.type.method.yaml.ansible", { link = "GruvboxFg1" })

hl("@identifier.ansible.name.key", { link = "GruvboxOrange" })
hl("@identifier.ansible.name.value", { bold = true })

hl("@keyword.directive.ansible.state.key", { link = "GruvboxOrange" })
hl("@keyword.directive.ansible.state.create.value", { link = "GruvboxGreen" })
hl("@keyword.directive.ansible.state.delete.value", { link = "GruvboxRed" })
hl("@keyword.directive.ansible.state.other.value", { link = "GruvboxFg1" })

hl("@keyword.directive.ignore.ansible", { link = "GruvboxRed" })

hl("@keyword.conditional.ansible.key", { fg = gruv.neutral_purple })
hl("@keyword.conditional.ansible.value", { fg = gruv.neutral_red })

hl("@keyword.repeat.ansible.key", { fg = gruv.neutral_purple })
hl("@keyword.repeat.ansible.value", { link = "GruvboxFg1" })

hl("@keyword.assignment.ansible.key", { fg = gruv.neutral_purple })
hl("@keyword.assignment.ansible.value", { link = "GruvboxYellow" })

hl("@variable.ansible", { link = "GruvboxYellow" })
