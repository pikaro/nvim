local log_file = "/tmp/nvim-buffer-change.log"
local initlog = io.open(log_file, "w")
if initlog then
	initlog:close()
end

local function log(msg)
	local ok, f = pcall(io.open, log_file, "a")
	if not ok or not f then
		vim.schedule(function()
			vim.notify("trace_edits: can't open log at " .. log_file, vim.log.levels.ERROR)
		end)
		return
	end
	f:write(os.date("%F %T ") .. msg .. "\n")
	f:write(debug.traceback("", 3) .. "\n\n")
	f:close()
end

-- prove it's loaded + writable
log("trace_edits loaded")

-- TEMP: no filetype filter until we catch the culprit
do
	local orig = vim.api.nvim_buf_set_lines
	vim.api.nvim_buf_set_lines = function(buf, start, stop, strict, lines)
		log("nvim_buf_set_lines buf=" .. tostring(buf))
		return orig(buf, start, stop, strict, lines)
	end
end

do
	local orig = vim.api.nvim_buf_set_text
	vim.api.nvim_buf_set_text = function(buf, sr, sc, er, ec, repl)
		log("nvim_buf_set_text buf=" .. tostring(buf))
		return orig(buf, sr, sc, er, ec, repl)
	end
end

do
	local orig = vim.lsp.util.apply_text_edits
	vim.lsp.util.apply_text_edits = function(edits, bufnr, enc)
		log("lsp.apply_text_edits bufnr=" .. tostring(bufnr))
		return orig(edits, bufnr, enc)
	end
end
