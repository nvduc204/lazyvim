return {
  {
    "nirmalravidas/nvim-javacreator",
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-java/nvim-java",
    event = "FileType java",
    config = function()
      require("java").setup()
      vim.lsp.enable("jdtls")
    end,
  },
}
