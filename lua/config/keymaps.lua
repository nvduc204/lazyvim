-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- jk -> Normal mode trong Insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- jk -> Normal mode trong Terminal mode
vim.keymap.set("t", "jk", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
