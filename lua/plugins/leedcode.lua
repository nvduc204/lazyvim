return {
	{
		"3rd/image.nvim",
		opts = {
			backend = "kitty",
			-- processor = "magick",
		},
	},
	{
		"kawre/leetcode.nvim",
		cmd = { "Leet" },
		-- build = ":tsupdate html", -- if you have `nvim-treesitter` installed
		dependencies = {
			-- include a picker of your choice, see picker section for more details
			"nvim-lua/plenary.nvim",
			"3rd/image.nvim",
			"muniftanjim/nui.nvim",
		},
		opts = {
			-- configuration goes here
			lang = "java",
			image_support = true,
		},
	},
}
