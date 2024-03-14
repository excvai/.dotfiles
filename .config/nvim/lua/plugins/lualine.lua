return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    -- Condition
    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    -- Configure sections

    local mode = {
      "mode",
      fmt = function()
        return "󰻃"
      end,
    }

    local branch = {
      "branch",
      icons_enabled = true,
      icon = { "", color = { fg = "#E8AB53" } },
      color = { fg = "#bbc2cf" },
    }

    local filename = {
      "filename",
      file_status = false,
      path = 1,
      cond = hide_in_width,
    }

    local diff = {
      "diff",
      source = function()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end,
      colored = true,
      symbols = { added = " ", modified = " ", removed = " " },
    }

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " ", hint = " " },
      colored = true,
      update_in_insert = false,
    }

    local filetype = {
      "filetype",
    }

    local spaces = function()
      local indent_type

      local expandtab = vim.bo.expandtab
      if expandtab then
        indent_type = "󱁐"
      else
        indent_type = ""
      end

      return indent_type .. " " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
    end

    local location = {
      "location",
    }

    local progress = function()
      local current_line = vim.fn.line(".")
      local total_lines = vim.fn.line("$")
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end

    lualine.setup({
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { branch },
        lualine_c = { filename, diff },
        lualine_x = { diagnostics, filetype, spaces },
        lualine_y = { location },
        lualine_z = { progress },
      },
    })
  end,
}
