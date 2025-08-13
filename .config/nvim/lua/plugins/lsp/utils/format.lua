local M = {}

-- Use only null-ls formatter if available
M.lsp_formatting = function(bufnr)
  local null_ls_sources = require("null-ls.sources")
  local ft = vim.bo[bufnr].filetype

  local has_null_ls = #null_ls_sources.get_available(ft, "NULL_LS_FORMATTING") > 0

  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      if has_null_ls then
        return client.name == "null-ls"
      else
        return true
      end
    end,
  })
end

return M
