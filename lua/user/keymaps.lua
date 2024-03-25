local nnoremap = require("user.keymap_utils").nnoremap
local vnoremap = require("user.keymap_utils").vnoremap
local inoremap = require("user.keymap_utils").inoremap
local tnoremap = require("user.keymap_utils").tnoremap
local xnoremap = require("user.keymap_utils").xnoremap
local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")
local utils = require("user.utils")

local M = {}

local TERM = os.getenv("TERM")

local wk = require("which-key")
-- Normal --
-- Disable Space bar since it'll be used as the leader key
nnoremap("<space>", "<nop>")

-- Window +  better kitty navigation
-- nnoremap("<C-j>", function()
-- 	if vim.fn.exists(":KittyNavigateDown") ~= 0 and TERM == "xterm-kitty" then
-- 		vim.cmd.KittyNavigateDown()
-- 	elseif vim.fn.exists(":NvimTmuxNavigateDown") ~= 0 then
-- 		vim.cmd.NvimTmuxNavigateDown()
-- 	else
-- 		vim.cmd.wincmd("j")
-- 	end
-- end)

-- nnoremap("<C-k>", function()
-- 	if vim.fn.exists(":KittyNavigateUp") ~= 0 and TERM == "xterm-kitty" then
-- 		vim.cmd.KittyNavigateUp()
-- 	elseif vim.fn.exists(":NvimTmuxNavigateUp") ~= 0 then
-- 		vim.cmd.NvimTmuxNavigateUp()
-- 	else
-- 		vim.cmd.wincmd("k")
-- 	end
-- end)

-- nnoremap("<C-l>", function()
-- 	if vim.fn.exists(":KittyNavigateRight") ~= 0 and TERM == "xterm-kitty" then
-- 		vim.cmd.KittyNavigateRight()
-- 	elseif vim.fn.exists(":NvimTmuxNavigateRight") ~= 0 then
-- 		vim.cmd.NvimTmuxNavigateRight()
-- 	else
-- 		vim.cmd.wincmd("l")
-- 	end
-- end)

-- nnoremap("<C-h>", function()
-- 	if vim.fn.exists(":KittyNavigateLeft") ~= 0 and TERM == "xterm-kitty" then
-- 		vim.cmd.KittyNavigateLeft()
-- 	elseif vim.fn.exists(":NvimTmuxNavigateLeft") ~= 0 then
-- 		vim.cmd.NvimTmuxNavigateLeft()
-- 	else
-- 		vim.cmd.wincmd("h")
-- 	end
-- end)

-- Swap between last two buffers
nnoremap("<leader>'", "<C-^>", { desc = "Switch to last buffer" })

-- Save with leader key
nnoremap("<leader>w", "<cmd>w<cr>", { silent = false })

-- Quit with leader key
nnoremap("<leader>q", "<cmd>q<cr>", { silent = false })

-- Save and Quit with leader key
nnoremap("<leader>z", "<cmd>wq<cr>", { silent = false })

-- Map Oil to <leader>e
nnoremap("<leader>e", function()
	require("oil").open()
end, { desc = "File Explorer" })

-- Center buffer while navigating
nnoremap("<C-u>", "<C-u>zz")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("{", "{zz")
nnoremap("}", "}zz")
nnoremap("N", "Nzz")
nnoremap("n", "nzz")
nnoremap("G", "Gzz")
nnoremap("gg", "ggzz")
nnoremap("<C-i>", "<C-i>zz")
nnoremap("<C-o>", "<C-o>zz")
nnoremap("%", "%zz")
nnoremap("*", "*zz")
nnoremap("#", "#zz")

-- Press 'S' for quick find/replace for the word under the cursor
nnoremap("S", function()
	local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end)

wk.register({
	["<leader>s"] = {
		name = "Search",
	},
})
-- Open Spectre for global find/replace
nnoremap("<leader>sr", function()
	require("spectre").open_visual({ select_word = true })
end, { desc = "Search and replace on all files" })

-- Open Spectre for global find/replace for the word under the cursor in normal mode
-- TODO Fix, currently being overriden by Telescope
nnoremap("<leader>sR", function()
	require("spectre").open_file_search({ select_word = true })
end, { desc = "Search and replace on current file" })

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
nnoremap("L", "$")
nnoremap("H", "^")

-- Press 'U' for redo
nnoremap("U", "<C-r>")

-- Turn off highlighted results
nnoremap("<leader>n", "<cmd>noh<cr>", { desc = "Clear Highlight" })

-- Diagnostics

-- Goto next diagnostic of any severity
nnoremap("]d", function()
	vim.diagnostic.goto_next({})
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto previous diagnostic of any severity
nnoremap("[d", function()
	vim.diagnostic.goto_prev({})
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto next error diagnostic
nnoremap("]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto previous error diagnostic
nnoremap("[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto next warning diagnostic
nnoremap("]w", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto previous warning diagnostic
nnoremap("[w", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Open the diagnostic under the cursor in a float window
nnoremap("<leader>d", function()
	vim.diagnostic.open_float({
		border = "rounded",
	})
end, { desc = "Diagnostics" })

-- Place all dignostics into a qflist
nnoremap("<leader>cd", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })

wk.register({
	["<leader>c"] = {
		name = "Quickfix",
	},
})
-- Navigate to next qflist item
nnoremap("<leader>cn", ":cnext<cr>zz")

-- Navigate to previos qflist item
nnoremap("<leader>cp", ":cprevious<cr>zz")

-- Open the qflist
nnoremap("<leader>co", ":copen<cr>zz")

-- Close the qflist
nnoremap("<leader>cc", ":cclose<cr>zz")

-- Map MaximizerToggle (szw/vim-maximizer) to leader-m
nnoremap("<leader>m", ":MaximizerToggle<cr>")

-- Resize split windows to be equal size
nnoremap("<leader>=", "<C-w>=")

-- -- Press leader f to format
-- nnoremap("<leader>f", function()
--   vim.lsp.buf.format()
-- end, { desc = "Format the current buffer" })

-- Press leader rw to rotate open windows
nnoremap("<leader>rw", ":RotateWindows<cr>", { desc = "[R]otate [W]indows" })

-- Press gx to open the link under the cursor
nnoremap("gx", ":sil !open <cWORD><cr>", { silent = true })

-- TSC autocommand keybind to run TypeScripts tsc
-- nnoremap("<leader>t", ":TSC<cr>", { desc = "[T]ypeScript [C]ompile" })
--
-- Harpoon keybinds --
-- Open harpoon ui

wk.register({
	["<leader>h"] = {
		name = "Harpoon",
	},
})
nnoremap("<leader>hh", function()
	harpoon_ui.toggle_quick_menu()
end, { desc = "Toggle Harpoon quick menu" })

-- Add current file to harpoon
nnoremap("<leader>ha", function()
	harpoon_mark.add_file()
end, { desc = "Add file to Harpoon" })

-- Remove current file from harpoon
nnoremap("<leader>hr", function()
	harpoon_mark.rm_file()
end, { desc = "Remove file from Harpoon" })

-- Remove all files from harpoon
nnoremap("<leader>hc", function()
	harpoon_mark.clear_all()
end, { desc = "Clear all file(s) from Harpoon" })

-- Quickly jump to harpooned files
nnoremap("<leader>1", function()
	harpoon_ui.nav_file(1)
end, { desc = "Go to Harpoon Mark 1" })

nnoremap("<leader>2", function()
	harpoon_ui.nav_file(2)
end, { desc = "Go to Harpoon Mark 2" })

nnoremap("<leader>3", function()
	harpoon_ui.nav_file(3)
end, { desc = "Go to Harpoon Mark 3" })

nnoremap("<leader>4", function()
	harpoon_ui.nav_file(4)
end, { desc = "Go to Harpoon Mark 4" })

nnoremap("<leader>5", function()
	harpoon_ui.nav_file(5)
end, { desc = "Go to Harpoon Mark 5" })

wk.register({
	["<leader>g"] = {
		name = "Git/Go",
	},
})
-- Git keymaps --
nnoremap("<leader>gb", ":Gitsigns toggle_current_line_blame<cr>")
nnoremap("<leader>gf", function()
	local cmd = {
		"sort",
		"-u",
		"<(git diff --name-only --cached)",
		"<(git diff --name-only)",
		"<(git diff --name-only --diff-filter=U)",
	}

	if not utils.is_git_directory() then
		vim.notify(
			"Current project is not a git directory",
			vim.log.levels.WARN,
			{ title = "Telescope Git Files", git_command = cmd }
		)
	else
		require("telescope.builtin").git_files()
	end
end, { desc = "Search [G]it [F]iles" })

wk.register({
	["<leader>f"] = {
		name = "Find",
	},
})

-- Telescope keybinds --
nnoremap("<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
nnoremap("<leader>fb", require("telescope.builtin").buffers, { desc = "[F]ind Open [B]uffers" })
nnoremap("<leader>ff", function()
	require("telescope.builtin").find_files({ hidden = true })
end, { desc = "[F]ind [F]iles" })
nnoremap("<leader>fh", require("telescope.builtin").help_tags, { desc = "[F]ind [H]elp" })
nnoremap("<leader>fw", require("telescope.builtin").live_grep, { desc = "[F]ind by [W]ord" })

nnoremap("<leader>fp", ":Telescope neovim-project discover<CR>", { desc = "[F]ind [p]rojects" })
nnoremap("<leader>fP", ":Telescope neovim-project history<CR>", { desc = "[F]ind Recent [P]rojects" })

nnoremap("<leader>fc", function()
	require("telescope.builtin").commands(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[F]ind [C]ommands" })

nnoremap("<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

nnoremap("<leader>fs", function()
	require("telescope.builtin").spell_suggest(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[F]ind [S]pelling suggestions" })

-- Go to context
nnoremap("gk", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, desc = "Go to [C]ontext" })

-- LSP Keybinds (exports a function to be used in ../../after/plugin/lsp.lua b/c we need a reference to the current buffer) --
M.map_lsp_keybinds = function(buffer_number)
	nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
	nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction", buffer = buffer_number })

	nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = buffer_number })

	-- Telescope LSP keybinds --
	nnoremap(
		"gr",
		require("telescope.builtin").lsp_references,
		{ desc = "LSP: [G]oto [R]eferences", buffer = buffer_number }
	)

	nnoremap(
		"gi",
		require("telescope.builtin").lsp_implementations,
		{ desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number }
	)

	-- See `:help K` for why this keymap
	nnoremap("D", vim.lsp.buf.hover, { desc = "LSP: Hover [D]ocumentation", buffer = buffer_number })
	nnoremap("<leader>k", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })
	inoremap("<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })

	-- Lesser used LSP functionality
	nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = buffer_number })
	nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: [T]ype [D]efinition", buffer = buffer_number })
end

-- Split Window
nnoremap("|", ":vsplit<CR>", { desc = "Vertical Split" })
nnoremap("\\", ":split<CR>", { desc = "Horizontal Split" })

-- Symbol Outline keybind
nnoremap("<leader>fo", ":SymbolsOutline<cr>")

-- Open Copilot panel
nnoremap("<leader>o", function()
	require("copilot.panel").open({})
end, { desc = "Open C[o]pilot panel" })

-- nvim-ufo keybinds
nnoremap("zR", require("ufo").openAllFolds)
nnoremap("zM", require("ufo").closeAllFolds)

-- Insert --
-- -- Map jj to <esc>
-- inoremap("jj", "<esc>")

-- Visual --
-- Disable Space bar since it'll be used as the leader key
vnoremap("<space>", "<nop>")

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vnoremap("L", "$<left>")
vnoremap("H", "^")

-- Paste without losing the contents of the register
vnoremap("<A-J>", ":m '>+1<CR>gv=gv")
vnoremap("<A-K>", ":m '<-2<CR>gv=gv")

-- Move line unselected
-- Left
nnoremap("<C-h>", function()
	vim.cmd("normal! <<")
end)

-- Right
nnoremap("<C-l>", function()
	vim.cmd("normal! >>")
end)

-- Down
nnoremap("<C-j>", ":MoveLine(1)<CR>")

-- Up
nnoremap("<C-k>", ":MoveLine(-1)<CR>")

-- Move line selected
-- Left
xnoremap("<C-h>", function()
	vim.cmd("normal! <<")
	vim.cmd("normal! gv")
end)

-- Right
xnoremap("<C-l>", function()
	vim.cmd("normal! >>")
	vim.cmd("normal! gv")
end)

-- Down
xnoremap("<C-j>", ":MoveBlock(1)<CR>")

-- Up
xnoremap("<C-k>", ":MoveBlock(-1)<CR>")

-- Terminal --
-- Enter normal mode while in a terminal
tnoremap("<C-i>", [[<C-\><C-n>]])
-- tnoremap("jj", [[<C-\><C-n>]])
--
-- Window navigation from terminal
tnoremap("<C-h>", [[<Cmd>wincmd h<CR>]])
tnoremap("<C-j>", [[<Cmd>wincmd j<CR>]])
tnoremap("<C-k>", [[<Cmd>wincmd k<CR>]])
tnoremap("<C-l>", [[<Cmd>wincmd l<CR>]])

-- Reenable default <space> functionality to prevent input delay
tnoremap("<space>", "<space>")

-- Flash Keybinds
wk.register({
	["<leader>j"] = {
		name = "Flash Jump",
	},
})

nnoremap("<leader>jj", function()
	require("flash").jump()
end, { desc = "Flash Jump" })

nnoremap("<leader>jt", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })

nnoremap("<leader>jr", function()
	require("flash").treesitter_search()
end, { desc = "Flash Treesitter Search" })

-- Terminal Keymaps
wk.register({
	["<leader>t"] = {
		name = "Terminal",
	},
})

nnoremap("<C-\\>", function()
	require("toggleterm").toggle()
end, { desc = "Toggle Terminal", silent = true })
tnoremap("<C-\\>", function()
	require("toggleterm").toggle()
end, { desc = "Toggle Terminal", silent = true })

nnoremap("<leader>tg", function()
	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

	lazygit:toggle()
end, { desc = "Toggle LazyGit" })

nnoremap("q", "q")

-- TS Tools
nnoremap("<leader>i", ":TSToolsAddMissingImports<CR>:TSToolsOrganizeImports<CR>", { desc = "Organize Imports" })

-- Octo
nnoremap("<leader>gg", ":Octo<CR>", { desc = "Open Octo Menu" })
nnoremap("<leader>gp", ":Octo search is:pr is:open review-requested:@me<CR>", { desc = "List PR Requested Reviews" })
nnoremap("<leader>ga", ":Octo search is:pr is:open author:@me<CR>", { desc = "List PR Author Me" })

return M
