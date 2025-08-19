vim.keymap.set('i', 'jk', "<Esc>") -- setting `jk` as exit

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<A-k>", ":m-2<CR>==")
vim.keymap.set("n", "<A-j>", ":m+1<CR>==")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {desc = "show the diagnostics in a floating window"})

----------------------- TABS -----------------------------------
vim.keymap.set({"n","i"}, "<C-h>", "<C-w>h")
vim.keymap.set({"n","i"}, "<C-j>", "<C-w>j")
vim.keymap.set({"n","i"}, "<C-k>", "<C-w>k")
vim.keymap.set({"n","i"}, "<C-l>", "<C-w>l")

----------------------- TELESCOPE ------------------------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Telescope live grep' })

----------------------- NVIMTREE -------------------------------
vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeFindFileToggle<CR>")
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapseKeepBuffers<CR>")

----------------------- CUSTOM ---------------------------------
-- CP setup
vim.keymap.set(
	"n",
	"<F5>",
	":w <CR> :!g++ -fsanitize=address -Wall -Wextra -Wshadow -DONPC -O2 -o r % <CR>",
	{ desc = "press to compile the current cpp file named output as r" }
) -- it simply compiles the code
-- input from a file setup
vim.keymap.set(
	"n",
	"<F6>",
	"<cmd>!g++ -fsanitize=address -Wall -Wextra -Wshadow -DONPC -O2 -o r % && ./r < input.txt > output.txt 2>&1 <CR>",
	{ desc = "press to compile the current cpp file named output as r" }
) -- it simply compiles the code
