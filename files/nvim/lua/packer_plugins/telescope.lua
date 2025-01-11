local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

local keymap = vim.keymap --for conciseness
local builtin = require "telescope.builtin"

keymap.set("n", "<leader>t", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd"})
keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find buffers"})
keymap.set('n', '<leader>b', function()
  builtin.buffers({
		ignore_current_buffer = true,
    sort_mru = true,
  })
end)
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find previously open files"})
keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy string in cwd"})
keymap.set("n", "<leader>ag", "<cmd>Telescope grep_string<cr>", { desc = "Fuzzy string under cursor in cwd"})
keymap.set("n", "<leader>r", "<cmd>Telescope command_history<cr>", { desc = "Fuzzy tind files in cwd"})


keymap.set('n','<leader>md', function()
	builtin.find_files {cwd = "$DOT_FILES_LOC", prompt_title = "<MYVIMRC>"}
end, {desc = '[Search] [M]y [D]ot Files'} )
keymap.set('n','<leader>ss', builtin.builtin, {desc = '[Search] [S]elect Telescope' })
keymap.set('n','<leader>sh', builtin.help_tags, {desc = '[Search] [H]elp' })
keymap.set('n','<leader>sd', builtin.diagnostics, {desc = '[Search] [D]iagnostics' })

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-h>"] = actions.preview_scrolling_left,
        ["<C-l>"] = actions.preview_scrolling_right,
        ["<M-h>"] = actions.results_scrolling_left,
        ["<M-l>"] = actions.results_scrolling_right,

        ["<C-c>"] = actions.close,
        ["jk"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,


        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-f>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>

      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
}
telescope.load_extension('fzf')
local M = {}

return M
