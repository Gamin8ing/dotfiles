-- set leader key to space
vim.g.mapleader = " "
vim.opt.timeoutlen = 700
local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Nvim-tree keymaps
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

-- Telescope keymaps
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

-- some keymaps for errors are defined in config/plugins/trouble.lua

-- setting up window switching
keymap.set({ "n" }, "<C-h>", "<C-w>h", { desc = "Switching to left window" })
keymap.set({ "n" }, "<C-l>", "<C-w>l", { desc = "Switching to right window" })
keymap.set({ "n" }, "<C-j>", "<C-w>j", { desc = "Switching to bottom window" })
keymap.set({ "n" }, "<C-k>", "<C-w>k", { desc = "Switching to top window" })

-- move lines up and down
keymap.set({ "n", "i" }, "<A-j>", "<cmd>m .+1<CR>", { desc = "Move line down" })
keymap.set({ "n", "i" }, "<A-k>", "<cmd>m .-2<CR>", { desc = "Move line up" })
keymap.set({ "i", "n" }, "<A-Down>", "<cmd>m .+1<CR>", { desc = "Move line down" })
keymap.set({ "i", "n" }, "<A-Up>", "<cmd>m .-2<CR>", { desc = "Move line up" })

keymap.set("i", "<C-BS>", "<C-w>", { desc = "delete a single word back using ctrl+back" })

-- MY OWN PlUGINS NOW
-- keymap.set("n", "<leader>cc", "<cmd>CommentToggle<CR>", { desc = "Toggle comment" }) -- toggle comment

-- CP setup
keymap.set(
	"n",
	"<F5>",
	":w <CR> :!g++ -fsanitize=address -Wall -Wextra -Wshadow -DONPC -O2 -o r % <CR>",
	{ desc = "press to compile the current cpp file named output as r" }
) -- it simply compiles the code
-- input from a file setup
keymap.set(
	"n",
	"<F6>",
	"<cmd>!g++ -fsanitize=address -Wall -Wextra -Wshadow -DONPC -O2 -o r % && ./r < input.txt > output.txt 2>&1 <CR>",
	{ desc = "press to compile the current cpp file named output as r" }
) -- it simply compiles the code
