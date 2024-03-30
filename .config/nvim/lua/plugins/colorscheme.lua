return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        styles = {
          italic = false,
        },
        highlight_groups = {
          Comment = { italic = true },
          Visual = { bg = "#2E3C64" },
          -- For flash plugin
          FlashBackdrop = {
            fg = "#545c7e",
          },
          FlashLabel = {
            bg = "#ff007c",
            bold = true,
            fg = "#c0caf5",
          },
        },
      })

      vim.cmd.colorscheme("rose-pine-moon")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode").setup({
        italic_comments = true,
        group_overrides = {
          Comment = {
            fg = "#908CAA",
          },
          -- For flash plugin
          FlashBackdrop = {
            fg = "#545c7e",
          },
          FlashLabel = {
            bg = "#ff007c",
            bold = true,
            fg = "#c0caf5",
          },
        },
      })
      -- require("vscode").load()
    end,
  },
}
