local plugins = {
	"Afourcat/treesitter-terraform-doc.nvim",
	"CopilotC-Nvim/CopilotChat.nvim",
	"L3MON4D3/LuaSnip",
	"christoomey/vim-tmux-navigator",
	"hashivim/vim-terraform",
	"haya14busa/vim-asterisk",
	"hrsh7th/cmp-buffer",
	"huggingface/llm.nvim",
	"jez/vim-superman",
	"lepture/vim-jinja",
	"mfussenegger/nvim-ansible",
	"ellisonleao/gruvbox.nvim",
	"neovim/nvim-lspconfig",
	"nvim-lua/lsp-status.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-context",
	"onsails/lspkind.nvim",
	"pangloss/vim-javascript",
	"rafamadriz/friendly-snippets",
	-- "roxma/vim-tmux-clipboard",
	"ryanoasis/vim-devicons",
	"saadparwaiz1/cmp_luasnip",
	"takelley1/ansible-doc.vim",
	"xolox/vim-misc",
	-- Temp replacement for hrsh7th/nvim-cmp with cmp window above line for Copilot
	{ "hrsh7th/cmp-nvim-lsp", dependencies = { "neovim/nvim-lspconfig" } },
	{ "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{ "nvim-tree/nvim-tree.lua", dependencies = { "ryanoasis/vim-devicons" } },
	{ "romgrk/barbar.nvim", dependencies = { "lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons" } },
	{ "tzachar/cmp-ai", dependencies = "nvim-lua/plenary.nvim" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "ryanoasis/vim-devicons", "nvim-tree/nvim-web-devicons", "nvim-lua/lsp-status.nvim" },
	},
}

local plugins_async = {
	{
		"dense-analysis/ale",
		event = { "BufReadPost" },
		config = "ale",
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPost" },
		config = "gitsigns",
	},
	{
		"llllvvuu/nvim-cmp",
		branch = "feat/above",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "tzachar/cmp-ai" },
		event = { "InsertEnter", "CmdlineEnter" },
		config = "cmp",
	},
	{
		"zbirenbaum/copilot.lua",
		event = { "BufReadPost" },
		config = "copilot",
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		config = "noice",
	},
	{
		"kylechui/nvim-surround",
		event = { "VeryLazy" },
		config = "surround",
	},
	{
		"XXiaoA/ns-textobject.nvim",
		dependencies = { "kylechui/nvim-surround" },
		event = { "InsertEnter" },
		config = "textobject",
	},
	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		config = "autopairs",
	},
	{
		"jonahgoldwastaken/copilot-status.nvim",
		dependencies = { "zbirenbaum/copilot.lua" },
		event = "BufReadPost",
		config = "copilot_status",
	},
	{
		"kkoomen/vim-doge",
		build = ":call doge#install()",
		event = "BufReadPost",
		config = nil,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPost" },
		config = "telescope",
	},
	{
		"https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
		event = { "BufReadPost" },
		config = "rainbow_delimiters",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPost",
		config = "indent_blankline",
		after = { "https://gitlab.com/HiPhish/rainbow-delimiters.nvim" },
	},
}

for _, v in ipairs(plugins_async) do
	if v.config then
		table.insert(
			plugins,
			vim.tbl_extend("force", v, {
				["config"] = require("plugins.async." .. v.config),
			})
		)
	else
		table.insert(plugins, v)
	end
end

-- Dump plugins table to file

local file = io.open(vim.fn.stdpath("data") .. "/plugins.lua", "w")
file:write("return " .. vim.inspect(plugins))
file:close()

vim.fn.system({
	"git",
	"clone",
	"--depth=1",
	"--filter=blob:none",
	"https://github.com/folke/lazy.nvim",
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
