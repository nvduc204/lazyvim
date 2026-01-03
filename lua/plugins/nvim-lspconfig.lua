return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = { "clangd" }, -- dùng clangd trong PATH (MSYS2)
        },
      },
    },
  },
}
