return (function()
	local magic_prefixes = { ["\\v"] = true, ["\\m"] = true, ["\\M"] = true, ["\\V"] = true }
	local function check_magic(str)
		if string.len(str) < 2 or magic_prefixes[string.sub(str, 1, 2)] then
			return str
		end
		return "\\v" .. str
	end

	local compiled_vim_regexes = setmetatable({}, {
		__index = function(t, pattern)
			local res = vim.regex(check_magic(pattern))
			rawset(t, pattern, res)
			return res
		end,
	})

	local function count(text, pattern)
		return select(2, text:gsub(pattern, ""))
	end

	--- @param match table<integer,TSNode[]>
	--- @param source integer|string
	--- @param predicate any[]
	--- @param any boolean
	return function(match, _, source, predicate, metadata)
		-- Looks terribly slow, but elapsed time is 10-20us per multiline match for
		-- sane patterns and matches.
		local capture_id = predicate[2] --[[@as integer]]
		local nodes = match[capture_id]
		assert(#nodes == 1, "#vim-match-offset! does not support captures on multiple nodes")

		local node = nodes[1]

		if not metadata[capture_id] then
			metadata[capture_id] = {}
		end

		local range = metadata[capture_id].range or { node:range() }

		local regex = compiled_vim_regexes[predicate[3]] ---@type vim.regex
		local multiline = predicate[4] == "m"
		local text = vim.treesitter.get_node_text(node, source)
		local _start, _end = regex:match_str(text)
		if _start then
			local match_text
			local pre_newlines = 0
			local match_newlines = 0
			local start_col
			if multiline then
				-- Account for strings like foo\nbar\n<pattern match>\nbaz
				local pre_text = text:sub(1, _start)
				-- Starting line
				pre_newlines = count(pre_text, "\n")
				if pre_newlines > 0 then
					-- Starting column in first line of pattern match
					start_col = pre_text:reverse():find("\n") - 1
				else
					start_col = range[2] + _start
				end
				match_text = text:sub(_start, _end)
				-- Number of newlines in pattern match
				match_newlines = count(match_text, "\n")
			end
			-- If no newlines before or in match, no need to adjust range
			if not (multiline and (pre_newlines > 0 or match_newlines > 0)) then
				range[4] = range[2] + _end
				range[2] = range[2] + _start
			else
				local end_col
				if match_newlines > 0 then
					-- Ending column in last line of pattern match
					end_col = match_text:reverse():find("\n") - 1
				else
					end_col = start_col + #match_text
				end
				range = {
					range[1] + pre_newlines,
					start_col,
					range[1] + pre_newlines + match_newlines,
					end_col,
				}
			end

			if range[1] < range[3] or (range[1] == range[3] and range[2] <= range[4]) then
				metadata[capture_id].range = range
			end
		end
	end
end)()
