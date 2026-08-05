local function is_python_triple_quote_keystroke(ctx, quote)
	if ctx.ft ~= "python" then
		return false
	end

	local preceding_quote = ctx:text_before_cursor(1) == quote
	return ctx:text_before_cursor(2) == quote:rep(2) or (preceding_quote and not ctx:is_after_cursor(quote))
end

return {
	mappings = {
		cmdline = false,
		disabled_filetypes = { "TelescopePrompt", "snacks_picker_input", "spectre_panel" },
		wrap = {
			-- Move a delimiter with an exact Vim motion, e.g. <C-b>E.
			["<C-b>"] = "motion",
			["<C-S-b>"] = "motion_reverse",
			-- Cycle a delimiter over syntax nodes without guessing from line text.
			["<M-e>"] = "treesitter",
			["<M-E>"] = "treesitter_reverse",
		},
		pairs = {
			["'"] = {
				{
					"''",
					when = function(ctx)
						return ctx:text_before_cursor(1) == "'"
					end,
					languages = { "nix" },
				},
				{
					"'''",
					when = function(ctx)
						return ctx:text_before_cursor(2) == "''"
					end,
					languages = { "toml" },
				},
				{
					"'",
					enter = false,
					space = false,
					when = function(ctx)
						return not is_python_triple_quote_keystroke(ctx, "'")
							and ctx.ft ~= "plaintext"
							and ctx.ft ~= "scheme"
							and ctx.ft ~= "fennel"
							and (not ctx.char_under_cursor:match("%w") or ctx:is_after_cursor("'"))
							and ctx.ts:blacklist("singlequote").matches
					end,
				},
			},
			['"'] = {
				{ 'r#"', '"#', languages = { "rust" }, priority = 100 },
				{
					'"""',
					when = function(ctx)
						return ctx:text_before_cursor(2) == '""'
					end,
					languages = { "elixir", "julia", "kotlin", "scala", "toml" },
				},
				{
					'"',
					enter = false,
					space = false,
					when = function(ctx)
						return not is_python_triple_quote_keystroke(ctx, '"')
					end,
				},
			},
		},
	},
	-- Keep Blink's parser watcher active, but let rainbow-delimiters.nvim own all visuals.
	highlights = {
		enabled = true,
		cmdline = false,
		groups = {},
		matchparen = { enabled = false },
	},
}
