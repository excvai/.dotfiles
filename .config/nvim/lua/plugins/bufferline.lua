return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      show_buffer_close_icons = false,
      right_mouse_command = "Bdelete! %d", -- use Bdelete to prevent a bug with closing neovim instead of buffer
      separator_style = "slant",
    },
    highlights = {
      buffer_selected = {
        italic = false
      }
    }
  },
}
