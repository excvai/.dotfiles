return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "auto", -- auto, main, moon, or dawn
        dark_variant = "moon", -- main, moon, or dawn
        styles = {
          italic = false,
          bold = false,
        },
        highlight_groups = {
          Comment = { italic = true },
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
        -- Use different background for Visual mode depending on the light/dark variant
        before_highlight = function(group, highlight, palette)
          local moonBase = "#232136"
          local mainBase = "#191724"
          local dawnBase = "#faf4ed"
          if group == "Visual" and (palette.base == moonBase or palette.base == mainBase) then
            highlight.bg = "#2E3C64"
          elseif group == "Visual" and palette.base == dawnBase then
            highlight.bg = "#ADD6FF"
          end
        end,
      })

      vim.cmd.colorscheme("rose-pine")
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
