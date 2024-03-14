vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
]])

local autocmd = vim.api.nvim_create_autocmd

-- Disable continuation of comments to the next line
autocmd("BufWinEnter", { command = "set formatoptions-=cro" })

-- Restore previous cursor position
autocmd("BufReadPost", {
  callback = function()
    vim.cmd([[
      if line("'\"") >= 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
    ]])
  end,
})

-- Highlight selected text
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Disable some vim features on large files
-- autocmd("BufReadPre", {
--   callback = function()
--     vim.cmd [[
--       let g:large_file = 512000 " 500kb
--
--       let f=expand("<afile>") |
--       \ if getfsize(f) > g:large_file |
--         \ set eventignore+=FileType |
--         \ setlocal noswapfile bufhidden=unload |
--       \ else |
--         \ set eventignore-=FileType |
--       \ endif
--     ]]
--   end
-- })

-- Enable json comments for tsconfig file
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "tsconfig.json" },
  callback = function()
    vim.opt_local.filetype = "jsonc"
  end,
})
