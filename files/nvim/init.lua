vim.g.mapleaderr = ' '
vim.g.maplocalleader = ' '



require('wincent') --contains folding expr
require("config")

--{{{ Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		local hello = 5
		print(hello)
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)
--}}}

--{{{ Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },     --import from plugins folder
		{ import = "plugins.lsp" }, --import from plugins.lsp folder
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true, notify = false, },
	change_detection = {
		notify = false,
	},
})
--}}}

-- vim.cmd("so ~/.config/nvim/config.vim")
--require("config")
-- require("user.packer_plugins")
-- vim.cmd("so ~/.config/nvim/plugins.vim")

-- require("user.cmp")
-- require("user.lsp")
-- require("user.telescope")
-- require("user.treesitter")
-- require("user.autopairs")
-- require("user.comment")
-- require("user.nvim-tree")
-- require("user.gitsigns")
-- require("user.lualine")
-- require("user.project")
-- require("user.impatient")
-- require("user.indentline")
-- require("user.aerial")

--require "user.alpha"
--require "user.whichkey"
--require "user.autocommands"
