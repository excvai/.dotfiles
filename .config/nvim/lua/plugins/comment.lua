return {
  "numToStr/Comment.nvim",
  enabled = false,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- to skip backwards nvim-ts-context-commentstring compatibility routines and speed up loading
    vim.g.skip_ts_context_commentstring_module = true

    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
