return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  -- Lazy load when open cmdline
  keys = { "/", ":" },
  dependencies = {
    -- Sources
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for system file paths
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-cmdline",

    -- Snippets
    {
      "L3MON4D3/LuaSnip", -- snippet engine
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp for transformations (optional!).
      -- build = "make install_jsregexp"
    },
    "saadparwaiz1/cmp_luasnip", -- source for LuaSnip
    "rafamadriz/friendly-snippets", -- useful snippets
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Update snippets on change in insert mode
    luasnip.config.set_config({
      updateevents = "TextChanged,TextChangedI",
    })

    -- Load basic friendly snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    -- Load custom local snippets
    for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/plugins/nvim-cmp/snippets/*.lua", true)) do
      loadfile(ft_path)()
    end

    cmp.setup({
      snippet = {
        -- Specify a snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-1),
        ["<C-f>"] = cmp.mapping.scroll_docs(1),
        ["<C-p>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-l>"] = cmp.mapping(function(fallback)
          if luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format("%s", require("core.icons")[vim_item.kind])
          -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            nvim_lua = "[NVIM_LUA]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
            calc = "[Calc]",
          })[entry.source.name]
          return vim_item
        end,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "calc" },
      },
      window = {
        documentation = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
      },
    })

    local cmdline_mapping = {
      ["<C-j>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
      },
      ["<C-k>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
      -- Use default nvim history scrolling
      ["<C-n>"] = {
        c = false,
      },
      ["<C-p>"] = {
        c = false,
      },
    }

    -- Add autocompletion for cmdline
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
      sources = {
        { name = "buffer" },
      },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })
  end,
}
