return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp", -- source for nvim-cmp
    "Issafalcon/lsp-overloads.nvim",
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    -- { "antosha417/nvim-lsp-file-operations", config = true },
    "b0o/schemastore.nvim", -- provides the SchemaStore catalog for use with jsonls and yamlls.
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup()
    mason_lspconfig.setup({
      ensure_installed = {
        "cssls",
        "dockerls",
        "emmet_language_server",
        "html",
        "jsonls",
        "yamlls",
        "lua_ls",
        "tailwindcss",
        "ts_ls",
      },
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    local icons = require("core.icons")
    local signs = {
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.WARN] = icons.Warn,
      [vim.diagnostic.severity.HINT] = icons.Hint,
      [vim.diagnostic.severity.INFO] = icons.Info,
    }

    vim.diagnostic.config({
      severity_sort = true,
      virtual_text = true,
      signs = { text = signs },
    })

    -- Add borders to the LSP floating windows
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

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
      keymap.set("n", "K", vim.lsp.buf.hover, opts)
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
    -- Function to setup lsp-overloads plugin
    local lsp_overloads = function(client)
      -- Guard against servers without the signatureHelper capability
      if client.server_capabilities.signatureHelpProvider then
        require("lsp-overloads").setup(client, {
          ui = {
            border = "rounded",
            close_events = { "CursorMoved", "CursorMovedI", "InsertCharPre" },
          },
          keymaps = {
            next_signature = "<Down>",
            previous_signature = "<Up>",
            next_parameter = "<Right>",
            previous_parameter = "<Left>",
            close_signature = "<C-s>",
          },
        })
      end
    end

    local on_attach = function(client, bufnr)
      set_keymaps(bufnr)
      highlight_symbol(client, bufnr)
      lsp_overloads(client)
      -- Disable built-in LSP formatters for some servers (to prevent conflicts with none-ls formatters)
      local disable_lsp_formatting = { "ts_ls", "lua_ls", "jsonls", "html" }
      for _, v in pairs(disable_lsp_formatting) do
        if client.name == v then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end
      end
      -- Enable tsserver(ts_ls) utils
      if client.name == "ts_ls" then
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({
          filter_out_diagnostics_by_code = { 80001 },
        })
        ts_utils.setup_client(client)
      end
    end

    -- Enable cmp autocompletion
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    mason_lspconfig.setup_handlers({
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      -- Next, you can provide a dedicated handler for specific servers.
      ["lua_ls"] = function()
        require("lspconfig")["lua_ls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize the `vim` global
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                -- make the language server aware of runtime files
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  -- Disable in order to avoid lua lsp find multiple location when using stow softlinks
                  -- [vim.fn.stdpath("config") .. "/lua"] = true,
                },
              },
            },
          },
        })
      end,
      ["emmet_language_server"] = function()
        require("lspconfig")["emmet_language_server"].setup({
          filetypes = {
            "css",
            "eruby",
            "html",
            "javascript",
            "javascriptreact",
            "less",
            "sass",
            "scss",
            "pug",
            "typescriptreact",
          },
          -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
          -- **Note:** only the options listed in the table are supported.
          init_options = {
            ---@type table<string, string>
            includeLanguages = {},
            --- @type string[]
            excludeLanguages = {},
            --- @type string[]
            extensionsPath = {},
            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
            preferences = {},
            --- @type boolean Defaults to `true`
            showAbbreviationSuggestions = true,
            --- @type "always" | "never" Defaults to `"always"`
            showExpandedAbbreviation = "always",
            --- @type boolean Defaults to `false`
            showSuggestionsAsSnippets = false,
            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
            syntaxProfiles = {},
            --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
            variables = {},
          },
        })
      end,
      ["jsonls"] = function()
        require("lspconfig")["jsonls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        })
      end,
      ["yamlls"] = function()
        require("lspconfig")["yamlls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            yaml = {
              schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- SchemaStore plugin and its advanced options like `ignore`.
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        })
      end,
      ["cssls"] = function()
        require("lspconfig")["cssls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            css = {
              validate = true,
              lint = {
                -- Disable lint warnings for @tailwind directive
                unknownAtRules = "ignore",
              },
            },
            scss = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
            less = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        })
      end,
    })
  end,
}
