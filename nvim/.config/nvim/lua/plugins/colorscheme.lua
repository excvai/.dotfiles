return {
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
}
