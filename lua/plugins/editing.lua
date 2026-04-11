return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "VeryLazy",
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = function()
      local ok, tscc = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
      return {
        pre_hook = ok and tscc.create_pre_hook() or nil,
      }
    end,
  },
}
