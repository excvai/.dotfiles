-- TODO: Remove repetitive code
return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = function()
    local set_keymaps = function(bufnr)
      local keymap = vim.keymap
      local opts = { noremap = true, silent = true, buffer = bufnr }
      opts.buffer = bufnr
      opts.desc = "Show LSP references"
      keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
      -- opts.desc = "See available code actions"
      -- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      -- opts.desc = "Smart rename"
      -- keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "gL", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
      opts.desc = "Show line diagnostics"
      keymap.set("n", "gl", '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "rounded" })<CR>', opts)
      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ float = { border = "rounded" }})<CR>', opts)
      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ float = { border = "rounded" }})<CR>', opts)
      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", '<cmd>lua vim.lsp.buf.hover({ border = "rounded" })<CR>', opts)
      opts.desc = "Show LSP signature help"
      keymap.set("n", "<C-s>", "<cmd>LspOverloadsSignature<CR>", opts)
      keymap.set("i", "<C-s>", "<cmd>LspOverloadsSignature<CR>", opts)
    end
    local highlight_symbol = function(client, bufnr)
      -- Set autocommands conditional on server_capabilities
      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", {
          clear = false,
        })
        vim.api.nvim_clear_autocmds({
          buffer = bufnr,
          group = "lsp_document_highlight",
        })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          group = "lsp_document_highlight",
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          group = "lsp_document_highlight",
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end

    require("flutter-tools").setup({
      lsp = {
        on_attach = function(client, bufnr)
          set_keymaps(bufnr)
          highlight_symbol(client, bufnr)
        end,
      },
    })
  end,
}
