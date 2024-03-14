local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local recurs_opts = { noremap = false, silent = true }
local expr_opts = { noremap = true, silent = true, expr = true }

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v", (use x instead of v to prevent keybindings in select mode)
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

------------- NORMAL -------------

-- Improved word replace
-- keymap("n", "ciw", "<cmd>let @/='\\<'.expand('<cword>').'\\>'<cr>\"_ciw", opts)
-- Disable next keymap in order to fix multiline cut
-- keymap("x", "c", "y<cmd>let @/=substitute(escape(@\", '/[*'), '\\n', '\\\\n', 'g')<cr>\"_cgn", opts)

-- Don't include whitespaces on ca', ca" and ca`
keymap("n", "ca'", "c2i'", opts)
keymap("n", 'ca"', 'c2i"', opts)
keymap("n", "ca`", "c2i`", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Append semicolon
keymap("n", "<S-Cr>", "A;<cr>", opts)

-- Execute node file
vim.cmd([[
autocmd FileType javascript nnoremap <buffer> <F5> :!node %<CR>
autocmd FileType typescript nnoremap <buffer> <F5> :!npx ts-node %<CR>
]])

-- Open command line for ":"
keymap("n", "Q", "q:", opts)

-- Paste text using mouse
keymap("n", "<MiddleMouse>", "p", opts)

-- Motion alternatives
keymap("n", "[[", "[{", opts)
keymap("n", "]]", "]}", opts)

keymap("n", "]{", "/{<cr>:noh<cr>", opts)
keymap("n", "]}", "/}<cr>:noh<cr>", opts)
keymap("n", "[{", "?{<cr>:noh<cr>", opts)
keymap("n", "[}", "?}<cr>:noh<cr>", opts)

keymap("n", "]<", "/<<cr>:noh<cr>", opts)
keymap("n", "]>", "/><cr>:noh<cr>", opts)
keymap("n", "[<", "?<<cr>:noh<cr>", opts)
keymap("n", "[>", "?><cr>:noh<cr>", opts)

-- Window splitting
keymap("n", "<C-w>h", "<C-w>s", opts)

-- Toggle spell check
-- keymap("n", "<F3>", ":set spell!<CR>", opts)
keymap("n", "<F3>", "ZT", recurs_opts)

-- Jumplist mutations
keymap("n", "k", '(v:count > 5 ? "m\'" . v:count : "") . \'k\'', expr_opts)
keymap("n", "j", '(v:count > 5 ? "m\'" . v:count : "") . \'j\'', expr_opts)

-- Add new line without insert mode (with count)
-- keymap('n', '<leader>o', ':<C-u>call append(line("."), repeat([""], v:count1))<cr>', opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)

-- Move buffers
keymap("n", "<leader>>", ":BufferLineMoveNext<cr>", opts)
keymap("n", "<leader><", ":BufferLineMovePrev<cr>", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<cr>", opts)
keymap("n", "<A-k>", ":m .-2<cr>", opts)

-- Replace default gx handler with custom function to improve its behaviour
vim.keymap.set("n", "gx", function()
  OpenExternal(vim.fn.expand("<cfile>"))
end)

------------- INSERT -------------

-- Undo break points
keymap("i", ",", ",<C-g>u", opts)
keymap("i", ".", ".<C-g>u", opts)
keymap("i", "!", "!<C-g>u", opts)
keymap("i", "?", "?<C-g>u", opts)

-- Delete a forward word
keymap("i", "<C-d>", "<Space><Esc>ce", opts)

-- Append semicolon
keymap("i", "<S-Cr>", "<Esc>A;<cr>", opts)

-- Disable default vim keybindings
keymap("i", "<C-h>", "<Nop>", opts)
keymap("i", "<C-l>", "<Nop>", opts)
keymap("i", "<C-e>", "<Nop>", opts)
keymap("i", "<C-y>", "<Nop>", opts)

-- Paste text using mouse
keymap("i", "<MiddleMouse>", "<C-r>+", opts)

-- Toggle spell check
-- keymap("i", "<F3>", "<C-O>:set spell!<CR>", opts)
keymap("i", "<F3>", "<C-O>ZT", recurs_opts)

------------- VISUAL -------------

-- Move text up and down
keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", opts)

-- Don't leave visual mode after indenting
keymap("x", "<", "<gv", opts)
keymap("x", ">", ">gv", opts)

-- Paste text using mouse
keymap("x", "<MiddleMouse>", "p", opts)

-- Additional way to copy selected text
keymap("x", "<C-c>", "y", opts)
keymap("x", "<RightMouse>", "y", opts)

-- Rename repetitive selected text
keymap("x", "<leader>ar", "y:.,$s:<C-r>0::Igc<left><left><left><left>", opts) -- replace
keymap("x", "<leader>aR", "y:.,$s:<C-r>0:<C-r>0:Igc<left><left><left><left>", opts) -- rename

-- Motion alternatives
keymap("x", "[[", "[{", opts)
keymap("x", "]]", "]}", opts)

keymap("x", "]{", "/{<cr>", opts)
keymap("x", "]}", "/}<cr>", opts)
keymap("x", "[{", "?{<cr>", opts)
keymap("x", "[}", "?}<cr>", opts)

keymap("x", "]<", "/<<cr>", opts)
keymap("x", "]>", "/><cr>", opts)
keymap("x", "[<", "?<<cr>", opts)
keymap("x", "[>", "?><cr>", opts)

-- Replace text without changing register's content
keymap("x", "p", '"_dP', opts)
keymap("x", "P", '"_dp', opts)
