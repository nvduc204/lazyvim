-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- jk -> Normal mode trong Insert mode
local Snacks = require("snacks")
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- jk -> Normal mode trong Terminal mode
vim.keymap.set("t", "jk", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Backspace: đóng buffer hiện tại
vim.keymap.set("n", "<BS>", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

-- \ : mở danh sách buffers
vim.keymap.set("n", "\\", function()
  Snacks.picker.buffers({
    focus = "list",
  })
end, { desc = "Buffers" })

-- F5 để chạy file (C, C++, Python, JavaScript)
local run_win = nil -- nhớ cửa sổ terminal của lần chạy trước

vim.keymap.set("n", "<F5>", function()
  local ft = vim.bo.filetype
  local file = vim.fn.expand("%:p")
  local dir = vim.fn.expand("%:p:h") -- lấy trước khi mở buffer mới
  local cmd

  -- Đóng terminal của lần chạy trước (giải phóng file .exe)
  if run_win and vim.api.nvim_win_is_valid(run_win) then
    vim.api.nvim_win_close(run_win, true)
  end
  run_win = nil

  if ft == "c" or ft == "cpp" then
    vim.cmd("write")
    local exe = vim.fn.expand("%:p:r") .. ".exe"
    local compiler = ft == "c" and "gcc" or "g++"
    local out = vim.fn.system({ compiler, file, "-o", exe })
    if vim.v.shell_error ~= 0 then
      vim.notify(out, vim.log.levels.ERROR)
      return
    end
    cmd = { exe }
  elseif ft == "python" then
    vim.cmd("write")
    local py = vim.fn.executable("py") == 1 and "py" or vim.fn.executable("python") == 1 and "python" or nil
    if not py then
      vim.notify("Không tìm thấy py hoặc python trong PATH", vim.log.levels.ERROR)
      return
    end
    cmd = { py, file }
  elseif ft == "javascript" then
    vim.cmd("write")
    cmd = { "node", file }
  elseif ft == "java" then
    vim.cmd("write")
    if vim.fn.executable("java") ~= 1 then
      vim.notify("Không tìm thấy java trong PATH", vim.log.levels.ERROR)
      return
    end
    cmd = { "java", file }
  else
    vim.notify("F5 chưa hỗ trợ filetype: " .. ft, vim.log.levels.WARN)
    return
  end

  -- Chạy trong terminal nhỏ phía dưới
  vim.cmd("belowright 12split | enew")
  run_win = vim.api.nvim_get_current_win()
  local opts = { cwd = dir }
  if vim.fn.has("nvim-0.11") == 1 then
    opts.term = true
    vim.fn.jobstart(cmd, opts)
  else
    vim.fn.termopen(cmd, opts)
  end
  vim.cmd("startinsert")
end, { desc = "Run current file" })
