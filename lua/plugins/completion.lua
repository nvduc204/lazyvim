return {
  {
    "saghen/blink.cmp",
    -- event = "InsertEnter",
    lazy = true,
    opts = function(_, opts)
      opts.enabled = function()
        local ft = vim.bo.filetype
        return ft ~= "snacks_picker_input"
      end

      opts.completion = opts.completion or {}

      opts.completion.menu = {
        border = "rounded",
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      }
      opts.completion.list = {
        selection = {
          preselect = false,
        },
      }
      opts.completion.documentation = {
        window = {
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
      }

      opts.keymap = {
        preset = "none",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Esc>"] = { "hide", "fallback" },
      }
    end,
  },
}
