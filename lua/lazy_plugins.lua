local plugins = {
	{ "ellisonleao/gruvbox.nvim", lazy = false, config = "gruvbox" },
	"Afourcat/treesitter-terraform-doc.nvim",
	"haya14busa/vim-asterisk",
	"hrsh7th/cmp-buffer",
	-- "huggingface/llm.nvim",
	"jez/vim-superman",
	-- "lepture/vim-jinja",
	"mfussenegger/nvim-ansible",
	"neovim/nvim-lspconfig",
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"onsails/lspkind.nvim",
	"pangloss/vim-javascript",
	-- "rafamadriz/friendly-snippets",
	"ryanoasis/vim-devicons",
	-- "saadparwaiz1/cmp_luasnip",
	"takelley1/ansible-doc.vim",
	"xolox/vim-misc",
	"aklt/plantuml-syntax",
	"creativenull/efmls-configs-nvim",
	{ "towolf/vim-helm", ft = "helm" },
	-- Temp replacement for hrsh7th/nvim-cmp with cmp window above line for Copilot
	{ "hrsh7th/cmp-nvim-lsp", dependencies = { "neovim/nvim-lspconfig" } },
	{ "knubie/vim-kitty-navigator" },
	{ "romgrk/barbar.nvim", dependencies = { "lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons" } },
	{ "tzachar/cmp-ai", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "williamboman/mason.nvim", config = "mason" },
	-- { "L3MON4D3/LuaSnip", config = "luasnip" },
	{ "nvim-treesitter/nvim-treesitter", config = "treesitter" },
	{ "rcarriga/nvim-notify", config = "notify" },
	{ "dense-analysis/ale", config = "ale" },
	{ "zbirenbaum/copilot.lua", config = "copilot" },
	{ "kkoomen/vim-doge", build = ":call doge#install()" },
	{ "https://gitlab.com/HiPhish/rainbow-delimiters.nvim", config = "rainbow_delimiters" },
	{ "williamboman/mason-lspconfig.nvim", config = "mason_lspconfig", dependencies = { "williamboman/mason.nvim" } },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "ryanoasis/vim-devicons", "nvim-tree/nvim-web-devicons", "nvim-lua/lsp-status.nvim" },
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
		event = "VeryLazy",
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
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = "autopairs",
	},
	{
		"jonahgoldwastaken/copilot-status.nvim",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = "copilot_status",
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
		dependencies = { "ryanoasis/vim-devicons" },
		cmd = "NvimTreeToggle",
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
		"nvim-pack/nvim-spectre",
		config = "spectre",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = "context",
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
	if v.dependencies then
		local dependencies = v.dependencies
		local after = v.after or {}
		after = vim.tbl_extend("force", after, dependencies)
		v.after = after
	end
end

vim.fn.system({
	"git",
	"clone",
	"--depth=1",
	"--filter=blob:none",
	"https://github.com/folke/lazy.nvim.git",
	"--branch=stable",
	vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
require("lazy").setup(plugins)

local local_plugin_path = vim.fn.expand("~/.vimrc.local-plugin")
if vim.fn.filereadable(local_plugin_path) == 1 then
	vim.cmd("source " .. local_plugin_path)
end
