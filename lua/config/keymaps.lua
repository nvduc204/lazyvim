-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
map("n", "<F5>", function()
  vim.cmd("w") -- Lưu file trước

  local ft = vim.bo.filetype -- Lấy loại file hiện tại

  local cmd = ""

  if ft == "cpp" then
    cmd = "g++ % -o %< && %<.exe"
  elseif ft == "c" then
    cmd = "gcc % -o %< && %<.exe"
  elseif ft == "python" then
    cmd = "python %"
  elseif ft == "javascript" then
    cmd = "node %"
  elseif ft == "java" then
    cmd = "javac % && java %<"
  else
    print("❌ Không hỗ trợ chạy file loại: " .. ft)

    return
  end

  -- Mở terminal ở split và chạy lệnh

  vim.cmd("botright split | terminal " .. cmd)

  vim.cmd("startinsert")
end, { desc = "Compile & Run (tự động nhận diện ngôn ngữ)" })

map("n", "<C-a>", "<cmd>normal! ggVG<CR>", { desc = "Select all", noremap = true })
map("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })
map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode with jk" })
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
