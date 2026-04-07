return {
  {
    "folke/snacks.nvim",
    opts = { terminal = { win = { border = "rounded" } } },

    config = function(_, opts)
      require("snacks").setup(opts)

      local api = vim.api
      local fn = vim.fn
      _G._quick_menu_win = nil

      local function is_menu_open()
        return _G._quick_menu_win and api.nvim_win_is_valid(_G._quick_menu_win)
      end

      local function close_menu()
        if is_menu_open() then
          api.nvim_win_close(_G._quick_menu_win, true)
          _G._quick_menu_win = nil
        end
      end

      local function toggle_quick_menu()
        if is_menu_open() then
          close_menu()
          return
        end

        local buffers = fn.getbufinfo({ buflisted = 1 })
        table.sort(buffers, function(a, b)
          return a.lastused > b.lastused
        end)
        local lines = {}

        for i, b in ipairs(buffers) do
          if i > 9 then
            break
          end
          local name = fn.fnamemodify(b.name, ":t")
          table.insert(lines, i .. ". " .. (name ~= "" and name or "[No Name]"))
        end

        local buf = api.nvim_create_buf(false, true)
        api.nvim_buf_set_option(buf, "bufhidden", "wipe")
        api.nvim_buf_set_lines(buf, 0, -1, false, lines)

        local ui = api.nvim_list_uis()[1]
        local width, height = 40, math.max(#lines, 1)
        local row = math.floor((ui.height - height) / 2)
        local col = math.floor((ui.width - width) / 2)

        _G._quick_menu_win = api.nvim_open_win(buf, true, {
          relative = "editor",
          width = width,
          height = height,
          row = row,
          col = col,
          style = "minimal",
          border = "rounded",
        })
        api.nvim_set_option_value(
          "winhighlight",
          "NormalFloat:Normal,FloatBorder:WinSeparator",
          { win = _G._quick_menu_win }
        )

        for i = 1, #lines do
          vim.keymap.set("n", tostring(i), function()
            local b = buffers[i]
            if b then
              close_menu()
              api.nvim_set_current_buf(b.bufnr)
            end
          end, { buffer = buf, nowait = true })
        end

        vim.keymap.set("n", "<Esc>", close_menu, { buffer = buf })
      end

      -- <C-i> and <Tab> are the same key in most terminals.
      -- Use a leader mapping so <C-i> keeps jump-forward behavior.
      vim.keymap.set("n", "\\", toggle_quick_menu, {
        desc = "Quick recent files",
      })

      vim.api.nvim_create_autocmd({ "BufLeave", "VimLeavePre" }, {
        callback = close_menu,
      })
    end,
  },
}
