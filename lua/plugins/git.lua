return {
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("octo").setup({
				enable_builtin = true,
				default_merge_method = "squash",
				suppress_missing_scope = {
					projects_v2 = true,
				},
				mappings = {
					submit_win = {
						approve_review = { lhs = "<leader>ra", desc = "approve review" },
						comment_review = { lhs = "<leader>rc", desc = "comment review" },
						request_changes = { lhs = "<leader>rr", desc = "request changes review" },
					},
				},
			})
		end,
	},
}
