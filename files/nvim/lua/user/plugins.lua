local fn = vim.fn

-- Automatically install packer{{{
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end
--}}}

-- Autocommand that reloads neovim whenever you save the plugins.lua file{{{
vim.cmd([[
augroup packer_user_config
	autocmd!
	autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])
--}}}

-- Init packer{{{
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})
--}}}

-- My plugins{{{
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Have packer manage itself

	--Base and General Functionality{{{
	use("nvim-lua/popup.nvim") -- Implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("lewis6991/impatient.nvim")
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	--}}}

	--  UI{{{
	use("lunarvim/darkplus.nvim")
	use("morhetz/gruvbox")
	use("kyazdani42/nvim-web-devicons")
	use("nvim-lualine/lualine.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	-- use "goolord/alpha-nvim"
	-- }}}
	-- Navigation{{{
	use("tpope/vim-unimpaired")
	use("kyazdani42/nvim-tree.lua")
	use("ahmedkhalf/project.nvim")
	use("terryma/vim-smooth-scroll")
	use("christoomey/vim-tmux-navigator")
	use("nelstrom/vim-visual-star-search")
	use("nvim-telescope/telescope.nvim")
	use({
		"stevearc/aerial.nvim", -- summary method leader+a
		config = function()
			require("aerial").setup()
		end,
	})

	-- use "folke/which-key.nvim"
	--}}}

	--Editing{{{
	use("https://github.com/tpope/vim-repeat.git")
	use("https://github.com/tpope/vim-surround.git")
	use("https://github.com/tommcdo/vim-exchange.git")
	use("windwp/nvim-autopairs") -- integrates with both cmp and treesitter
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use
	--}}}
	--Javascript{{{{
	-- use('mustache/vim-mustache-handlebars')
	--}
	-- cmp plugins{{{
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	--}}}

	--	LSP{{{
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("frbor/python-lsp-autoimport") -- for formatters and linters
	use("pedro757/emmet") -- for emmet web-dev
	--}}}

	-- Git{{{
	use("lewis6991/gitsigns.nvim")
	use("tpope/vim-fugitive")
	--}}}

	--Bootstrap packer{{{
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
	--}}}
end)
--}}}
