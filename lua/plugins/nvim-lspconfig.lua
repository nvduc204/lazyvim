return {
	{
		"neovim/nvim-lspconfig",
		event = "LazyFile",
		opts = { diagnostics = { virtual_text = false } },
		-- opts = function(_, opts)
		--   opts.servers = opts.servers or {}
		--   opts.servers.vtsls = opts.servers.vtsls or {}
		--   opts.servers.vtsls.settings = {
		--     typescript = {
		--       inlayHints = {
		--         parameterNames = { enabled = "none" },
		--         parameterTypes = { enabled = false },
		--         variableTypes = { enabled = false },
		--         propertyDeclarationTypes = { enabled = false },
		--         functionLikeReturnTypes = { enabled = false },
		--         enumMemberValues = { enabled = false },
		--       },
		--     },
		--     javascript = {
		--       inlayHints = {
		--         parameterNames = { enabled = "none" },
		--         parameterTypes = { enabled = false },
		--         variableTypes = { enabled = false },
		--         propertyDeclarationTypes = { enabled = false },
		--         functionLikeReturnTypes = { enabled = false },
		--         enumMemberValues = { enabled = false },
		--       },
		--     },
		--   }
		--   return opts
		-- end,
	},
}
