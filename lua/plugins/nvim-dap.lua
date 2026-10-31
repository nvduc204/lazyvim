return {
  "mfussenegger/nvim-dap",
  cmd = {
    "DapContinue",
    "DapToggleBreakpoint",
  },
  opts = function()
    local dap = require("dap")
    local mason = vim.fn.stdpath("data") .. "/mason/packages"

    ---------------------------------------------------------------------------
    -- NestJS / Node
    ---------------------------------------------------------------------------
    local js_debug = mason .. "/js-debug-adapter/js-debug/src/dapDebugServer.js"

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "127.0.0.1",
      port = "${port}",
      executable = {
        command = "node",
        args = { js_debug, "${port}", "127.0.0.1" },
      },
    }

    for _, ft in ipairs({ "javascript", "typescript" }) do
      dap.configurations[ft] = dap.configurations[ft] or {}
      table.insert(dap.configurations[ft], {
        type = "pwa-node",
        request = "attach",
        name = "Attach NestJS (9229)",
        address = "127.0.0.1",
        port = 9229,
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        restart = true,
        outFiles = { "${workspaceFolder}/dist/**/*.js" },
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      })
    end

    ---------------------------------------------------------------------------
    -- C / C++ (codelldb)
    ---------------------------------------------------------------------------
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = mason .. "/codelldb/extension/adapter/codelldb.exe",
        args = { "--port", "${port}" },
        detached = false, -- bắt buộc trên Windows
      },
    }

    for _, ft in ipairs({ "c", "cpp" }) do
      dap.configurations[ft] = {
        {
          name = "Launch exe",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to exe: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          console = "integratedTerminal",
        },
      }
    end
  end,
}
