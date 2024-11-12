-- Determines the colorscheme variant to be used based on the system theme
vim.cmd([[
if has("mac")
  let output =  system("defaults read -g AppleInterfaceStyle")
  if v:shell_error != 0
    set background=light
  else    
    set background=dark
  endif
else
  set background=dark
endif
]])

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
      -- vim.cmd.colorscheme("rose-pine")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        day_brightness = 0.3, -- adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        on_colors = function(colors)
          colors.terminal_black = "#64748b" -- use brighter variant to better see unused variables
          colors.border = "#565f89" -- more clear separator when using multiple windows
        end,
        on_highlights = function(hl, c)
          hl.TelescopePromptBorder = {
            fg = c.blue3,
          }
          hl.TelescopePromptTitle = {
            fg = c.blue3,
          }
          hl.CursorLineNr = { fg = "#c0caf5" } -- use white color to highlight current line number
        end,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
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
