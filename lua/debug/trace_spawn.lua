local log = io.open("/tmp/nvim-spawn.log", "w")
local function write(msg)
	if log then
		log:write(os.date("%F %T ") .. msg .. "\n")
		log:flush()
	end
end

-- Wrap vim.system (Neovim 0.10+)
if vim.system then
	local orig = vim.system
	vim.system = function(cmd, opts, on_exit)
		write("vim.system: " .. vim.inspect(cmd))
		return orig(cmd, opts, on_exit)
	end
end

-- Wrap jobstart (used by lots of plugins)
do
	local orig = vim.fn.jobstart
	vim.fn.jobstart = function(cmd, opts)
		write("jobstart: " .. vim.inspect(cmd))
		return orig(cmd, opts)
	end
end

-- Wrap libuv spawn (some plugins go this low)
do
	local orig = vim.loop.spawn
	vim.loop.spawn = function(file, options, on_exit)
		write("uv.spawn: " .. tostring(file) .. " " .. vim.inspect(options and options.args))
		return orig(file, options, on_exit)
	end
end
