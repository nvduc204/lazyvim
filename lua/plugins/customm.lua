return {
	{ "folke/flash.nvim", enabled = false },
	-- { "folke/tokyonight.nvim", enabled = false },
	{
		"nvim-mini/mini.surround",
		version = false,
	},
	{
		"saghen/blink.cmp",
		opts = {
			keymap = {
				preset = "enter",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-l>"] = { "accept", "fallback" },
			},
		},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		opts = {},
	},
}
