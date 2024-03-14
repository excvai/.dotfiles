return {
  "folke/flash.nvim",
  event = "VeryLazy",
  vscode = true,
  opts = {
    modes = {
      search = {
        enabled = false,
      },
      char = {
        enabled = false,
      },
    },
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
  },
}
