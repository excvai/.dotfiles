return {
  "nvim-treesitter/nvim-treesitter",
  -- Use specific commit to avoid bug with tsx wrong indentation inside tags
  -- commit = "6e0b031ebb212e7082bc3007f8b9614cb393465c",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    {
      "windwp/nvim-ts-autotag",
      -- Use specific commit as this plugin doesn't work on latest commit
      -- commit = "a65b202cfd08e0e69e531eab737205ff5bc082a4",
    },
  },
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "lua",
        "bash",
        "json",
        "javascript",
        "jsdoc",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "scss",
        "dockerfile",
        "gitignore",
        "rust",
        "markdown",
        "markdown_inline",
        -- Disable due to performance issues
        -- "comment", -- for comment tags like TODO, FIXME(user)
      },
      highlight = {
        enable = true,
        -- disable treesitter highlight for large files
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KiB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = { enable = true },
      autotag = {
        enable = true,
        -- disable due to a bug (https://github.com/windwp/nvim-ts-autotag/issues/125)
        enable_close_on_slash = false,
      },
      -- Disable incremental_selection since C-Space is used for tmux
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     init_selection = "<C-space>",
      --     node_incremental = "<C-space>",
      --     scope_incremental = false,
      --     node_decremental = "<bs>",
      --   },
      -- },
    })
  end,
}
