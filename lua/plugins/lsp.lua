return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = { virtual_text = false },
      servers = {
        -- Disable bashls (comes from LazyVim extras.util.dot) to stop auto install
        -- jdtls = {},
        tsserver = {},
        clangd = {
          -- Sửa lỗi encoding UTF-8/UTF-16 conflict với Copilot
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          flags = {
            debounce_text_changes = 150,
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            -- Dưới đây là đường dẫn g++ của bạn
            "--query-driver=C:\\Users\\Duc\\AppData\\Local\\Microsoft\\WinGet\\Packages\\**\\bin\\g++.exe",
          },
        },
      },
    },
  },
}
