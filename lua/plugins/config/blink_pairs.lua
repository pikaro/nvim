local completion_pairing_disabled = {
	bash = true,
	context = true,
	haskell = true,
	helm = true,
	nix = true,
	plaintex = true,
	purescript = true,
	sh = true,
	tex = true,
}

local lisp_filetypes = {
	clojure = true,
	clojurescript = true,
	fennel = true,
	janet = true,
}

local function feed_insert(keys)
	vim.api.nvim_feedkeys(vim.keycode(keys), "i", true)
end

local function completion_already_has_pair(item)
	local text_edit = item.textEdit and item.textEdit.newText
	return (text_edit and text_edit:match("[%(%[%$]")) or (item.insertText and item.insertText:match("[%(%[%$]"))
end

local function setup_completion_pairing()
	local cmp = require("cmp")
	local kinds = cmp.lsp.CompletionItemKind
	local pair_mappings = require("blink.pairs.mappings")

	cmp.event:on("confirm_done", function(event)
		if event.commit_character or not pair_mappings.is_enabled() then
			return
		end

		local filetype = vim.bo.filetype
		if completion_pairing_disabled[filetype] then
			return
		end

		local item = event.entry:get_completion_item()
		if item.kind ~= kinds.Function and item.kind ~= kinds.Method then
			return
		end

		if filetype == "python" and type(item.data) == "table" then
			item.data.funcParensDisabled = false
		elseif type(item.data) == "table" and item.data.funcParensDisabled then
			return
		end

		local cursor = vim.api.nvim_win_get_cursor(0)
		local line = vim.api.nvim_get_current_line()
		local char_before = line:sub(cursor[2], cursor[2])
		local char_after = line:sub(cursor[2] + 1, cursor[2] + 1)
		if char_before == "(" or char_after == "(" or completion_already_has_pair(item) then
			return
		end

		if lisp_filetypes[filetype] then
			local label_length = #item.label
			feed_insert(string.rep("<Left>", label_length) .. "(" .. string.rep("<Right>", label_length) .. "<Space>")
			return
		end

		feed_insert("(")
	end)
end

return function()
	require("blink.pairs").setup(require("plugins.options.blink"))
	setup_completion_pairing()
end
