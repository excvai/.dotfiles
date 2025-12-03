return {
  "nvimtools/none-ls.nvim", -- configure formatters & linters
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
    "nvimtools/none-ls-extras.nvim"
  },
  config = function()
    local null_ls = require("null-ls")

    require("mason-null-ls").setup({
      ensure_installed = {
        -- "prettierd", -- prettier formatter
        -- "prettier" -- installed locally
        "stylua", -- lua formatter
        "eslint_d", -- js linter
        "black", -- python formatter
      },
    })

    -- -- to setup format on save
    -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      -- add package.json as identifier for root (for typescript monorepos)
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
      -- setup formatters & linters
      sources = {
        null_ls.builtins.formatting.prettier.with({
          extra_filetypes = { "svelte" },
          -- disabled_filetypes = { "html" },
        }), -- js/ts formatter
        null_ls.builtins.formatting.stylua, -- lua formatter
        null_ls.builtins.formatting.black,
        require('none-ls.diagnostics.eslint_d').with({ -- js/ts linter
          condition = function(utils)
            return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs" }) -- only enable if root has one of specified files
          end,
        }),
        require('none-ls.code_actions.eslint_d'),
      },
      -- -- configure format on save
      -- on_attach = function(current_client, bufnr)
      --   if current_client.supports_method("textDocument/formatting") then
      --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      --     vim.api.nvim_create_autocmd("BufWritePre", {
      --       group = augroup,
      --       buffer = bufnr,
      --       callback = function()
      --         vim.lsp.buf.format({
      --           filter = function(client)
      --             --  only use null-ls for formatting instead of lsp server
      --             return client.name == "null-ls"
      --           end,
      --           bufnr = bufnr,
      --         })
      --       end,
      --     })
      --   end
      -- end,
    })
  end,
}
