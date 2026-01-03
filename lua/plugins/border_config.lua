return {
  -- Config viền cho Noice (messages, cmdline, notifications)
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },

  -- Config viền cho LSP
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = function()
  --     -- Set border cho LSP floating windows
  --     local windows = require("lspconfig.ui.windows")
  --     windows.default_options.border = "rounded"
  --   end,
  -- },

  -- Config viền cho Mason
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
}
