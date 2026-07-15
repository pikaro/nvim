local function cmd(name, fn, opts)
	vim.api.nvim_create_user_command(name, fn, opts or {})
end

local function cmdproxy(commands)
	return function(opts)
		local ret = ""
		for i, command in ipairs(commands) do
			if i > 1 then
				ret = ret .. " | "
			end
			ret = ret .. command .. (opts.bang and "!" or "")
		end

		return vim.cmd(ret)
	end
end

cmd("ALEDisableFixers", function()
	vim.g.ale_fix_on_save = 0
end)

cmd("ALEEnableFixers", function()
	vim.g.ale_fix_on_save = 1
end)

cmd("ALEToggleFixers", function()
	vim.g.ale_fix_on_save = vim.g.ale_fix_on_save == 0 and 1 or 0
end)

cmd("VimLog", function()
	local log = vim.fn.stdpath("log") .. "/log"
	vim.cmd("edit " .. log)
end)

cmd("SuperMan", function(opts)
	vim.api.nvim_cmd({
		cmd = "Man",
		args = vim.split(opts.args, "%s+", { trimempty = true }),
	}, {})

	if vim.api.nvim_buf_line_count(0) == 1 then
		vim.cmd.cquit()
	end

	vim.cmd("silent only")
	vim.opt_local.readonly = true
	vim.opt_local.modifiable = false
	vim.opt_local.swapfile = false
	vim.opt_local.expandtab = false
	vim.opt_local.tabstop = 8
	vim.opt_local.softtabstop = 8
	vim.opt_local.shiftwidth = 8
	vim.opt_local.list = false
	vim.opt_local.colorcolumn = "0"
	vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = true, silent = true, desc = "Close man page" })
end, { nargs = "+", complete = "shellcmd" })

cmd("W", function()
	local file = vim.fn.expand("%")
	if vim.fn.empty(vim.fn.getbufvar(vim.fn.bufname("%"), "&buftype")) and not file:match("^%w+:/") then
		local dir = vim.fn.fnamemodify(file, ":h")
		if not vim.fn.isdirectory(dir) then
			vim.fn.mkdir(dir, "p")
		end
	end
	vim.cmd("write")
end)

cmd("Q", cmdproxy({ "quitall" }), { bang = true })
cmd("Wq", cmdproxy({ "write", "quit" }), { bang = true })
cmd("WQ", cmdproxy({ "write", "quit" }), { bang = true })

_G.print_to_buffer = require("functions/print_to_buffer")
