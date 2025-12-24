return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      custom_filter = function(bufnr)
        local tabnr = vim.fn.tabpagenr()
        local tab_buffers = {}

        -- số window trong tab hiện tại
        local win_count = vim.fn.tabpagewinnr(tabnr, "$")

        for i = 1, win_count do
          local winid = vim.fn.win_getid(i, tabnr)
          local b = vim.fn.winbufnr(winid)
          tab_buffers[b] = true
        end

        return tab_buffers[bufnr] == true
      end,
    },
  },
}
