local o = vim.opt

o.encoding = "utf8"
o.fileformats = { "unix", "dos", "mac" }

o.shortmess:append("I")

--  Sets how many lines of history VIM has to remember
o.history = 500

--  Set to auto read when a file is changed from the outside
o.autoread = true

vim.g.mapleader = "\\"
vim.g.maplocalleader = vim.api.nvim_replace_termcodes("<BS>", true, true, true)

-- """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--  => VIM user interface
-- """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--  Mouse
o.mouse:append("a")

--  Set 7 lines to the cursor - when moving vertically using j/k
o.scrolloff = 7

--  Turn on the Wild menu
o.wildmenu = true

-- Open splits to the right
o.splitright = true

--  Ignore compiled files
local separator = vim.fn.has("win32") and "\\" or "/"
o.wildignore:append({
	"*.o",
	"*~",
	"*.pyc",
	"__pycache__",
	"venv",
	".venv",
	"node_modules",
	"dist",
	"build",
	"target",
	".git",
	".DS_Store",
	".git" .. separator .. "*",
	".hg" .. separator .. "*",
	".svn" .. separator .. "*",
})

-- Always show current position
o.ruler = true
o.cursorline = true

-- Always show status line
o.laststatus = 2

--  Height of the command bar
o.cmdheight = 2

--  A buffer becomes hidden when it is abandoned
o.hidden = true

--  Configure backspace so it acts as it should act
o.backspace = { "eol", "start", "indent" }

-- hl<> Cursor in normal mode, [] would be insert mode
o.whichwrap:append({ ["<"] = true, [">"] = true, ["h"] = true, ["l"] = true })

--  Ignore case when searching
o.ignorecase = true

--  When searching try to be smart about cases
o.smartcase = true

--  Highlight search results
o.hlsearch = true

--  Makes search act like search in modern browsers
o.incsearch = true

--  For regular expressions turn magic on
o.magic = true

--  Show matching brackets when text indicator is over them
o.showmatch = true
--  How many tenths of a second to blink when matching brackets
o.matchtime = 2

--  No annoying sound on errors
o.errorbells = false
o.visualbell = false
o.timeoutlen = 500

--  Add a bit extra margin to the left
o.foldcolumn = "1"

--  Turn backup off, since most stuff is in SVN, git et.c anyway...
o.backup = false
o.writebackup = false
o.swapfile = false

--  Enable level folding
o.foldenable = true
o.foldlevel = 10
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"

--  Use spaces instead of tabs
o.expandtab = true

--  Be smart when using tabs ;)
o.smarttab = true

--  1 tab == 4 spaces
o.shiftwidth = 4
o.tabstop = 4

o.autoindent = true
o.wrap = true

-- Specify the behavior when switching between buffers
o.switchbuf = { "useopen", "usetab", "newtab" }
o.showtabline = 2

-- Show signcolumn
o.signcolumn = "yes"

-- Show numbers and relativenumber
o.number = true
o.relativenumber = true
vim.wo.number = true
vim.wo.relativenumber = true

-- Set viminfo
o.viminfo = "<1000,'50,/50,:1000,h,f0"

-- Copy to system clipboard
o.clipboard = "unnamedplus"

-- Syntax
o.syntax = "off"
