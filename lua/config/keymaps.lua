local map = vim.keymap.set

local run_term = nil
local function run_term_opts()
  return {
    win = {
      position = "float",
      width = 0.9,
      height = 0.9,
    },
  }
end

local function ensure_run_term()
  local term = Snacks.terminal.get(nil, run_term_opts())
  run_term = term
  return term
end

local function toggle_run_term()
  local term = Snacks.terminal.toggle(nil, run_term_opts())
  run_term = term
end

map("n", "<F5>", function()
  vim.cmd("w")

  local ft = vim.bo.filetype
  local file = vim.fn.expand("%:p")
  local filename = vim.fn.expand("%:t")
  local classname = vim.fn.expand("%:t:r")
  local dir = vim.fn.expand("%:p:h")
  -- local output = vim.fn.expand("%:r")

  local cmd = ""

  if ft == "cpp" then
    cmd = table.concat({
      'cd "' .. dir .. '"',
      'g++ "' .. filename .. '" -o "' .. classname .. '"',
      "if ($?) { .\\" .. classname .. ".exe }",
    }, "; ")
  elseif ft == "python" then
    cmd = 'python "' .. file .. '"'
  elseif ft == "javascript" then
    cmd = 'node "' .. file .. '"'
  elseif ft == "java" then
    cmd = table.concat({
      'cd "' .. dir .. '"',
      'javac "' .. filename .. '"',
      "if ($?) { java " .. classname .. " }",
    }, "; ")
  else
    vim.notify("Không hỗ trợ filetype: " .. ft, vim.log.levels.WARN)
    return
  end

  local term = ensure_run_term()
  if term then
    term:show()
  end

  vim.defer_fn(function()
    local buf = run_term and run_term.buf or nil
    if buf and vim.api.nvim_buf_is_valid(buf) then
      local ok, job_id = pcall(vim.api.nvim_buf_get_var, buf, "terminal_job_id")
      if ok and job_id then
        vim.fn.chansend(job_id, cmd .. "\r")
      else
        vim.notify("Không lấy được terminal_job_id!", vim.log.levels.ERROR)
      end
    else
      vim.notify("Terminal buffer không hợp lệ!", vim.log.levels.ERROR)
    end
  end, 0)
end, { desc = "Run current file" })

map("n", "<C-a>", function()
  vim.cmd("normal! ggVG")
end, { desc = "Select all", noremap = true, silent = true })
map("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })
map("t", "jk", [[<C-\><C-n>]], { desc = "Exit terminal mode with jk" })
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
map({ "n", "t" }, "<C-/>", toggle_run_term, { desc = "Toggle run terminal" })
map({ "n", "t" }, "<C-_>", toggle_run_term, { desc = "Toggle run terminal (compat)" })
map("n", "ss", ":split<Return>", { desc = "" })
map("n", "sv", ":vsplit<Return>", { desc = "" })
-- map("n", "s", "<Nop>", { desc = "Disable default s functionality" })
-- Sử dụng vim.schedule để đảm bảo lệnh chạy sau khi các tác vụ UI khác đã xong
map("n", "sd", function()
  vim.schedule(function()
    require("lazyvim.util").pick("diagnostics", { bufnr = 0 })()
  end)
end, { desc = "Buffer Diagnostics" })

map("n", "sj", vim.lsp.buf.code_action, { desc = "action code" })
map("n", "sk", function()
  vim.lsp.buf.code_action({
    context = {
      only = { "source" },
      diagnostics = {},
    },
  })
end, { desc = "Source Action" })
