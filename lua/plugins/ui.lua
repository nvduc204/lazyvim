return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
            },
          },
        },
      },
    },
  },
  -- { "folke/flash.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
