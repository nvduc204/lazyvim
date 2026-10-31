return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "java",
        "javascript",
        "lua",
        "vim",
        "vimdoc",
      },
    },
  },
}
