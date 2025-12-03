return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  priority = 1000,
  config = function()
    require("dashboard").setup({
    theme = "hyper",          -- theme: "doom" hoặc "hyper"
    disable_move = false,     -- có disable phím di chuyển không
    shortcut_type = "letter", -- "letter" hoặc "number"
    shuffle_letter = false,   -- sắp xếp random cho letter shortcuts
    letter_list = "abcdefghilmnopqrstuvwxyz", -- danh sách letter, mặc định a-z trừ j,k
    change_to_vcs_root = false, -- mở file theo MRU, chuyển đến root VCS

    config = {                -- config riêng cho theme
        header = { "Welcome to Neovim!" },
        center = {
            { icon = "  ", desc = "Recently opened files", action = "Telescope oldfiles" },
        },
    },

    hide = {                  -- ẩn các thành phần giao diện
        statusline = true,
        tabline = true,
        winbar = true,
    },

    preview = {               -- cấu hình preview file
        command = "cat",
        file_path = "~/.config/nvim/static/neovim.cat",
        file_height = 12,
        file_width = 80,
    },
})
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}

