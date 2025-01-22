return {
  {
    'LunarVim/darkplus.nvim',
    priority = 1000,
    init = function()
      vim.cmd [[colorscheme darkplus]]
    end,
  },
	{ "ntk148v/habamax.nvim", dependencies={ "rktjmp/lush.nvim" } },
	'folke/tokyonight.nvim',
}
