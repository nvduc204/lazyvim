return {
  "folke/snacks.nvim",
  event = "VeryLazy",
  opts = {
    dashboard = { enabled = false },
    picker = {
      enabled = true,
      respect_gitignore = false,
      actions = {},
      sources = {
        explorer = {
          respect_gitignore = false,
          dotfiles = true,
          ignored = true,
          filters = {
            exclude = {},
          },
        },
      },
    },
  },
}
