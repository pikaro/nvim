-- Doge
vim.g.doge_enable_mappings = 0
vim.g.doge_doc_standard_python = "sphinx"

-- vim-terraform
vim.g.terraform_fmt_on_save = 1

-- tmux-navigator
vim.g.tmux_navigator_no_wrap = 1

-- vim-tmux-clipboard
-- Also copy to system clipboard
-- let g:vim_tmux_clipboard#loadb_option = '-w'
vim.g['vim_tmux_clipboard#loadb_option'] = '-w'
