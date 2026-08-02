return {
  { "folke/flash.nvim", enabled = false },
  {
    "nvim-mini/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup()
    end,
  },
}
