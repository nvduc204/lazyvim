-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`

-- Fix j/k in file tree/picker buffers (override LazyVim's wrapped j/k)
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(ev)
    if vim.bo[ev.buf].filetype == "snacks_picker_list" and vim.fn.mode():find("^i") then
      vim.cmd("stopinsert")
    end
  end,
})

-- Ensure Yes is always the first choice in all confirm/select prompts
do
  local function normalize_label(s)
    s = tostring(s or "")
    s = s:gsub("&", ""):gsub("%s*%b()", ""):gsub("^%s+", ""):gsub("%s+$", "")
    return s:lower()
  end

  local yes_words = {
    ["yes"] = true,
    ["y"] = true,
    ["ok"] = true,
    ["okay"] = true,
    ["accept"] = true,
    ["có"] = true,
    ["co"] = true,
  }

  local no_words = {
    ["no"] = true,
    ["n"] = true,
    ["cancel"] = true,
    ["không"] = true,
    ["khong"] = true,
  }

  local function is_yes(label)
    if yes_words[label] then
      return true
    end
    return label:match("^yes") ~= nil
  end

  local function is_no(label)
    if no_words[label] then
      return true
    end
    return label:match("^no") ~= nil
  end

  -- vim.ui.select: move Yes to the front
  local orig_select = vim.ui.select
  vim.ui.select = function(items, opts, on_choice)
    opts = opts or {}
    local format_item = opts.format_item
    local indexed = {}
    local has_yes, has_no = false, false

    for i, item in ipairs(items or {}) do
      local label
      if format_item then
        label = format_item(item)
      elseif type(item) == "string" then
        label = item
      else
        label = tostring(item)
      end
      local norm = normalize_label(label)
      local yes = is_yes(norm)
      local no = is_no(norm)
      has_yes = has_yes or yes
      has_no = has_no or no
      indexed[#indexed + 1] = { item = item, yes = yes, idx = i }
    end

    if not (has_yes and has_no) then
      return orig_select(items, opts, on_choice)
    end

    local reordered = {}
    for _, v in ipairs(indexed) do
      if v.yes then
        reordered[#reordered + 1] = v.item
      end
    end
    for _, v in ipairs(indexed) do
      if not v.yes then
        reordered[#reordered + 1] = v.item
      end
    end

    return orig_select(reordered, opts, on_choice)
  end

  -- vim.fn.confirm: move Yes to the front and fix default index
  local orig_confirm = vim.fn.confirm
  vim.fn.confirm = function(msg, choices, default, type)
    if type(choices) ~= "string" then
      return orig_confirm(msg, choices, default, type)
    end

    local parts = vim.split(choices, "\n", { plain = true, trimempty = true })
    local indexed = {}
    local has_yes, has_no = false, false

    for i, part in ipairs(parts) do
      local norm = normalize_label(part)
      local yes = is_yes(norm)
      local no = is_no(norm)
      has_yes = has_yes or yes
      has_no = has_no or no
      indexed[#indexed + 1] = { text = part, yes = yes, idx = i }
    end

    if not (has_yes and has_no) then
      return orig_confirm(msg, choices, default, type)
    end

    local reordered = {}
    for _, v in ipairs(indexed) do
      if v.yes then
        reordered[#reordered + 1] = v
      end
    end
    for _, v in ipairs(indexed) do
      if not v.yes then
        reordered[#reordered + 1] = v
      end
    end

    local new_default = default
    if type(default) == "number" and default > 0 then
      for i, v in ipairs(reordered) do
        if v.idx == default then
          new_default = i
          break
        end
      end
    end

    local new_choices = {}
    for _, v in ipairs(reordered) do
      new_choices[#new_choices + 1] = v.text
    end

    return orig_confirm(msg, table.concat(new_choices, "\n"), new_default, type)
  end
end

-- Override Snacks confirm to put Yes first everywhere
local function override_snacks_confirm()
  local ok, util = pcall(require, "snacks.picker.util")
  if not ok or not util or type(util.confirm) ~= "function" then
    return
  end
  util.confirm = function(prompt, fn)
    require("snacks").picker.select({ "Yes", "No" }, {
      prompt = prompt,
      snacks = {
        layout = {
          layout = {
            max_width = 60,
          },
        },
      },
    }, function(_, idx)
      if idx == 1 then
        fn()
      end
    end)
  end
end

override_snacks_confirm()
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = override_snacks_confirm,
})

-- NOTE: removed custom wshada handler; it can interfere with clean exit on Windows
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    vim.cmd("redraw!")
  end,
})
