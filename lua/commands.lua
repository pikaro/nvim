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
