return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
