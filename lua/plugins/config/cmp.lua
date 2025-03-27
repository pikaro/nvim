local has_words_before = function()
	local unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return function()
	local lspkind = require("lspkind")
	-- local luasnip = require("luasnip")
	local cmp = require("cmp")
	cmp.setup({
		preselect = cmp.PreselectMode.None,
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				ellipsis_char = "…",
				show_labelDetails = true,
			}),
		},
		-- snippet = {
		-- 	expand = function(args)
		-- 		require("luasnip").lsp_expand(args.body)
		-- 	end,
		-- },
		sources = {
			-- { name = "luasnip" },
			-- Use via keybind instead -- { name = 'cmp_ai' },
			-- DOES work even if CmpStatus says no - enter Insert first
			{ name = "nvim_lsp" },
			{
				name = "buffer",
				option = {
					get_bufnrs = function()
						return vim.api.nvim_list_bufs()
					end,
				},
			},
		},
		view = {
			entries = {
				vertical_positioning = "above",
			},
		},
		mapping = {
			["<cr>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = false,
			}),
			["<C-e>"] = cmp.mapping.close(),
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-l>"] = cmp.mapping.complete(),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				--	elseif luasnip.expand_or_jumpable() then
				--		luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				-- elseif luasnip.jumpable(-1) then
				--	luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),

			["<C-x>"] = cmp.mapping(
				cmp.mapping.complete({
					config = {
						sources = cmp.config.sources({
							{ name = "cmp_ai" },
						}),
					},
				}),
				{ "i" }
			),
		},
	})
end
