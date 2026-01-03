return {

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1, -- hiển thị đường dẫn
            symbols = {
              modified = " ●", -- chưa lưu
              readonly = " ", -- read-only
              unnamed = "[No Name]",
            },
          },
        },
      },
    },
  },

  -- disable flash.nvim if không dùng
  { "folke/flash.nvim", enabled = false },
}
