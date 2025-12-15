return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    -- ===== CUSTOM COLORS =====
    vim.api.nvim_set_hl(0, "DashApps",    { fg = "#7aa2f7", bold = true })   -- xanh dương
    vim.api.nvim_set_hl(0, "DashFiles",   { fg = "#9ece6a", bold = true })   -- xanh lá
    vim.api.nvim_set_hl(0, "DashProjects",{ fg = "#e0af68", bold = true })   -- vàng cam
    vim.api.nvim_set_hl(0, "DashConfig",  { fg = "#bb9af7", bold = true })   -- tím
    vim.api.nvim_set_hl(0, "DashQuit",    { fg = "#f7768e", bold = true })   -- đỏ

    require("dashboard").setup({
      shortcut_type = "number",
      hide = {
        statusline = false,
        tabline = true,
        winbar = true,
      },

      config = {
        shortcut = {

          -- Apps
          {
            desc = " Lazy",
            group = "DashApps",
            action = "Lazy",
            key = "l",
          },

          -- Files
          {
            icon = " ",
            icon_hl = "DashFiles",
            desc = "Files",
            group = "DashFiles",
            action = "Telescope find_files",
            key = "f",
          },

          -- Projects
          {
            icon = " ",
            icon_hl = "DashProjects",
            desc = "Projects",
            group = "DashProjects",
            action = "Telescope projects",
            key = "p",
          },

          -- Config
          {
            desc = " Config",
            group = "DashConfig",
            action = "Telescope find_files cwd=C:\\\\Users\\\\ADMIN\\\\AppData\\\\Local\\\\nvim",
            key = "c",
          },

          -- Quit
          {
            desc = " Quit",
            key = "q",
            group = "DashQuit",
            action = "qa",
          },
        },
      },
    })
  end,

  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
}
