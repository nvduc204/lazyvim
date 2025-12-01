return {
  -- 🌙 Tokyonight theme (vẫn load sớm, vì cần cho UI ngay từ đầu)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- 🔍 Telescope – chỉ load khi nhấn phím tắt
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope", -- chỉ load khi gọi lệnh Telescope
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- 🧠 LSP Config – chỉ load khi đọc file (chứ không khi mở nvim trống)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      diagnostics = { virtual_text = false },
    },
  },

  -- 🌳 Treesitter – lazy load sau khi mở file
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "tsx", "typescript" })
    end,
  },


}
