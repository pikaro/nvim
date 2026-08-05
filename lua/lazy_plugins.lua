local is_headless = require("functions.is_headless")

local function is_interactive()
	return not is_headless()
end

local plugins = {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		config = "gruvbox",
	},
	"Afourcat/treesitter-terraform-doc.nvim",
	"rapan931/lasterisk.nvim",
	"hrsh7th/cmp-buffer",
	-- "huggingface/llm.nvim",
	-- "lepture/vim-jinja",
	"mfussenegger/nvim-ansible",
	"neovim/nvim-lspconfig",
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"onsails/lspkind.nvim",
	-- "rafamadriz/friendly-snippets",
	-- "saadparwaiz1/cmp_luasnip",
	"takelley1/ansible-doc.vim",
	"aklt/plantuml-syntax",
	"creativenull/efmls-configs-nvim",
	"tpope/vim-fugitive",
	"lukas-reineke/cmp-under-comparator",
	{ "towolf/vim-helm", ft = "helm" },
	{ "hrsh7th/cmp-nvim-lsp", dependencies = { "neovim/nvim-lspconfig" } },
	{ "knubie/vim-kitty-navigator" },
	{
		"romgrk/barbar.nvim",
		dependencies = { "lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons" },
	},
	{ "tzachar/cmp-ai", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "williamboman/mason.nvim", config = "mason" },
	{ "nvim-treesitter/nvim-treesitter", config = "treesitter" },
	{ "rcarriga/nvim-notify", config = "notify" },
	-- { "dense-analysis/ale", config = "ale" },
	{
		"zbirenbaum/copilot.lua",
		cond = is_interactive,
		config = "copilot",
		-- WARNING: Do not lazy-load core Copilot on InsertEnter. It misses the first
		-- insert session because suggestion autocmds are registered after the event.
		lazy = false,
		-- requires = { "copilotlsp-nvim/copilot-lsp" }, -- NES is annoying
	},
	-- { "copilotlsp-nvim/copilot-lsp", config = "copilot_lsp" },
	{ "kkoomen/vim-doge", build = ":call doge#install()" },
	{ "HiPhish/rainbow-delimiters.nvim", config = "rainbow_delimiters", submodules = false },
	{
		"williamboman/mason-lspconfig.nvim",
		config = "mason_lspconfig",
		dependencies = { "williamboman/mason.nvim" },
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = "lualine",
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = "gitsigns",
	},
	{
		"llllvvuu/nvim-cmp",
		branch = "feat/above",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "tzachar/cmp-ai" },
		config = "cmp",
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		cmd = {
			"CopilotChat",
			"CopilotChatClose",
			"CopilotChatLoad",
			"CopilotChatModels",
			"CopilotChatOpen",
			"CopilotChatPrompts",
			"CopilotChatReset",
			"CopilotChatSave",
			"CopilotChatStop",
			"CopilotChatToggle",
		},
		cond = is_interactive,
		dependencies = { "zbirenbaum/copilot.lua", "nvim-lua/plenary.nvim" },
		build = "make tiktoken",
		config = "copilot_chat",
	},
	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		config = "noice",
	},
	{
		"saghen/blink.pairs",
		version = "*",
		event = "InsertEnter",
		-- Compile the checked-out source instead of downloading a release binary.
		build = function()
			require("blink.pairs").build():pwait(60000)
		end,
		dependencies = { "saghen/blink.lib" },
		opts = "blink",
		config = "blink_pairs",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = "telescope",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = "indent_blankline",
		dependencies = { "https://gitlab.com/HiPhish/rainbow-delimiters.nvim" },
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = "tree",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = "treesitter_textobjects",
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = "trouble",
	},
	{
		"ray-x/go.nvim",
		config = "go",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		build = ':lua require("go.install").update_all_sync()',
	},
	-- {
	-- 	"folke/which-key.nvim",
	-- 	cond = is_interactive,
	-- 	opts = "whichkey",
	-- 	event = "VeryLazy",
	-- },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = "todo",
	},
	{
		"folke/zen-mode.nvim",
		opts = "zen",
		dependencies = { "folke/todo-comments.nvim" },
	},
	{
		"MagicDuck/grug-far.nvim",
		config = "grug_far",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = "context",
	},
	{
		"andythigpen/nvim-coverage",
		config = "coverage",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- {
	-- 	"GeorgesAlkhouri/nvim-aider",
	-- 	dependencies = {
	-- 		"folke/snacks.nvim",
	-- 		"nvim-tree/nvim-tree.lua",
	-- 	},
	-- 	config = "aider",
	-- },
	{
		"MysticalDevil/inlay-hints.nvim",
		event = "LspAttach",
		dependencies = { "neovim/nvim-lspconfig" },
		config = "inlay_hints",
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
}

for _, v in ipairs(plugins) do
	if v.config then
		local config = v.config
		v.config = function()
			require("plugins.config." .. config)()
		end
	end
	if v.opts then
		local options = v.opts
		v.opts = require("plugins.options." .. options)
	end
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("lazy").setup(plugins)

local local_plugin_path = vim.fn.expand("~/.vimrc.local-plugin")
if vim.fn.filereadable(local_plugin_path) == 1 then
	vim.cmd("source " .. local_plugin_path)
end
