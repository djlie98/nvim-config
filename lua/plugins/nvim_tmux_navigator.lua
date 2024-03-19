return {
	{
		"alexghergh/nvim-tmux-navigation",
		config = function()
			local nav = require("nvim-tmux-navigation")
			nav.setup({
				disable_when_zoomed = true,
			})

			vim.keymap.set("n", "<M-h>", nav.NvimTmuxNavigateLeft)
			vim.keymap.set("n", "<M-j>", nav.NvimTmuxNavigateDown)
			vim.keymap.set("n", "<M-k>", nav.NvimTmuxNavigateUp)
			vim.keymap.set("n", "<M-l>", nav.NvimTmuxNavigateRight)
			vim.keymap.set("n", "<M-\\>", nav.NvimTmuxNavigateLastActive)
			vim.keymap.set("n", "<M-Space>", nav.NvimTmuxNavigateNext)
		end,
	},
}
