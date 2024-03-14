-- TODO: rewrite into lua style
vim.cmd([[
function! s:DeleteAllBuffers()
  exe "bufdo :Bdelete"
endfunction
com! Ba call s:DeleteAllBuffers()

" Check diff current buffer with saved buffer
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
]])

-- Print a table
function P(v)
  print(vim.inspect(v))
  return v
end

-- Function to open URL under cursor with browser
function OpenExternal(file)
  local sysname = vim.loop.os_uname().sysname:lower()
  local jobcmd
  if sysname:match("windows") then
    jobcmd = ("start %s"):format(file)
  else
    jobcmd = { "xdg-open", file }
  end
  local job = vim.fn.jobstart(jobcmd, {
    -- Don't kill the started process when nvim exits.
    detach = true,

    -- Make relative paths relative to the current file.
    cwd = vim.fn.expand("%:p:h"),
  })
  -- Kill the job after 5 seconds.
  local delay = 5000
  vim.defer_fn(function()
    vim.fn.jobstop(job)
  end, delay)
end
