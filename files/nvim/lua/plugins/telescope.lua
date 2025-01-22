local actions = require "telescope.actions"

local keymap = vim.keymap --for conciseness
local builtin = require "telescope.builtin"

local keys = {
	{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer search" },
	{ "<leader>b", function() builtin.buffers({ ignore_current_buffer = true, sort_mru = true, }) end, desc = "Buffers" },
	{ "<leader>t", "<cmd>Telescope find_files<cr>", desc = "Find All Files" },
	{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Git files" },
	{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
	{ "<leader>sr", "<cmd>Telescope command_history<cr>", desc = "History" },
	{ "<leader>sc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
	{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
	{ "<leader>sl", "<cmd>Telescope lsp_references<cr>", desc = "Lsp References" },
	{ "<leader>so", "<cmd>Telescope oldfiles<cr>", desc = "Old files" },
	{ "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Ripgrep" },
	{ "<leader>ag", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
	{ "<leader>st", "<cmd>Telescope treesitter<cr>", desc = "Treesitter" },
	{ "<leader>md", function() builtin.find_files({ cwd = "$DOT_FILES_LOC", prompt_title = "<MYVIMRC>" }) end, desc = "Find my dot files" },
	{ "<leader>ss", builtin.builtin, desc = "[Search] [S]elect Telescope" },
	{ "<leader>ss", builtin.diagnostics, desc = "[Search] [D]iagnostics" },
}

local config = function()
	local telescope = require("telescope")
	local actions = require ("telescope.actions")
	telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
					--navigate telescope search history
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-h>"] = actions.preview_scrolling_left,
        ["<C-l>"] = actions.preview_scrolling_right,
        ["<M-h>"] = actions.results_scrolling_left,
        ["<M-l>"] = actions.results_scrolling_right,

        ["jk"] = actions.close,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["?"] = actions.which_key,
      },
    },
  },
})

  telescope.load_extension("fzf")
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
	keys = keys,
	config = config,
}
