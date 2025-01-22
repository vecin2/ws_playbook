--It provides autocompletions when typing.
--Neovim LSP comes with basic omnifunc completion that can be activated
--with <Ctrl+x><Ctrl+o>
--cmp with 'nvim_lsp' source provides auto completion triggered when user
--is typing

return {
	"hrsh7th/nvim-cmp",
	dependencies= {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
    "onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			sources = cmp.config.sources({
				{ name = 'lazydev' },
				{ name = 'nvim_lsp' },
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- text within current buffer
			}),
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = {
						-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						-- menu = function() return math.floor(0.45 * vim.o.columns) end,
						menu = 50, -- leading text (labelDetails)
						abbr = 50, -- actual suggestion item
					},
					ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					show_labelDetails = true, -- show labelDetails in menu. Disabled by default
				}),
			},
		})
	end
}
