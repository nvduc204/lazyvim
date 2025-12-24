return {

  -- 🌙 Tokyonight theme
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        -- sidebars = "transparent",
        floats = "normal",
      },
    },
  },

  -- ⭐ Project.nvim — load sớm để Projects hoạt động ngay lần đầu
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git", "package.json", "Makefile" },
        silent_chdir = true,
      })
    end,
  },

  -- 🔍 Telescope – lazy load bằng lệnh
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },

    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          initial_mode = "normal",
          winblend = 0,
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",

          mappings = {
            n = {
              q = actions.close, -- nhấn q để thoát
            },
          },
        },
      }
    end,

    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      telescope.load_extension("projects") -- ⭐ extension cho project.nvim
    end,
  },

  -- 🧠 LSP — load khi mở file
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      diagnostics = { virtual_text = false },
    },
  },

  -- 🌳 Treesitter — load khi mở file
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "tsx", "typescript" })
    end,
  },

  -- ✂ Mini Surround — plugin nhẹ, giữ simple
  {
    "nvim-mini/mini.surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "sa",
          delete = "sd",
          find = "sf",
          find_left = "sF",
          highlight = "sh",
          replace = "sr",
          update_n_lines = "sn",
        },
        highlight_duration = 3500,
      })
    end,
  },

  { "folke/flash.nvim", enabled = false },
}
