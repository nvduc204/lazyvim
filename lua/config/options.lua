-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.opt.shell = "powershell.exe"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true -- nên BẬT cái này
-- vim.o.shadafile = "NONE"

-- Force apply fillchars sau khi LazyVim load
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.fillchars = {
      vert = "┃",
      vertleft = "┫",
      vertright = "┣",
      horiz = "━",
      horizup = "┻",
      horizdown = "┳",
      verthoriz = "╋",
    }
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#7aa2f7", bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1a1b26" })
  end,
})
