return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    local wk = require("which-key")

    wk.setup({
      -- Disable icons
      icons = { mappings = false },
    })

    wk.add({
      {
        "<leader>b",
        "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false, sort_mru = true, ignore_current_buffer = true})<CR>",
        desc = "Buffers",
      },
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Explorer" },
      { "<leader>w", "<cmd>w<CR>", desc = "Save" },
      { "<leader>q", "<cmd>qa<CR>", desc = "Quit Neovim" },
      { "<leader>x", "<cmd>q<CR>", desc = "Close window" },
      { "<leader>c", "<cmd>Bdelete<CR>", desc = "Close Buffer" },
      { "<leader>C", "<cmd>Ba<CR>", desc = "Close All Buffers" },
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "UndoTree toggle" },
      {
        "<leader>f",
        "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>",
        desc = "Find file",
      },
      { "<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', desc = "New Line" },
      { "<leader>p", "<cmd>Lazy<CR>", desc = "Plugins" },
      { "<leader>;", "<cmd>Alpha<CR>", desc = "Dashboard" },

      { "<leader>a", group = "Additional" },
      { "<leader>ad", "<cmd>cd %:h<CR>", desc = "CD to opened file's dir" },
      { "<leader>ar", "yiw:.,$s:<C-r>0::Igc<left><left><left><left>", desc = "Replace repetitive words" },
      { "<leader>aR", "yiw:.,$s:<C-r>0:<C-r>0:Igc<left><left><left><left>", desc = "Rename repetitive words" },
      { "<leader>ah", "<cmd>ColorizerToggle<CR>", desc = "Toggle colorizer" },
      { "<leader>a/", "/[\\u0401\\u0451\\u0410-\\u044f]<CR>", desc = "Highlight russian characters" },

      { "<leader>g", group = "Git" },
      { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Lazygit" },
      { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<CR>", desc = "Next Hunk" },
      { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", desc = "Prev Hunk" },
      { "<leader>gL", "<cmd>lua require 'gitsigns'.blame_line()<CR>", desc = "Blame" },
      { "<leader>gl", "<cmd>Gllog<CR>", desc = "Git log" },
      { "<leader>gh", "<cmd>0Gllog<CR>", desc = "Git file history" },
      { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", desc = "Preview Hunk" },
      { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", desc = "Reset Hunk" },
      { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", desc = "Reset Buffer" },
      { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", desc = "Stage Hunk" },
      { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", desc = "Undo Stage Hunk" },
      { "<leader>go", "<cmd>Telescope git_status<CR>", desc = "Open changed file" },
      { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Checkout branch" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Checkout commit" },
      { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<CR>", desc = "Diff" },
      { "<leader>gf", ":DiffSave<CR>", desc = "Diff with saved" },

      { "<leader>l", group = "LSP" },
      { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
      { "<leader>ld", "<cmd>Telescope lsp_document_diagnostics<CR>", desc = "Document Diagnostics" },
      { "<leader>lw", "<cmd>Telescope lsp_workspace_diagnostics<CR>", desc = "Workspace Diagnostics" },
      { "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", desc = "Format" },
      { "<leader>li", "<cmd>LspInfo<CR>", desc = "Info" },
      { "<leader>lI", "<cmd>Mason<CR>", desc = "Mason Info" },
      { "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
      { "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", desc = "Prev Diagnostic" },
      { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<CR>", desc = "CodeLens Action" },
      { "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", desc = "Quickfix" },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
      { "<leader>lR", "<cmd>TSLspRenameFile<CR>", desc = "Rename file" },
      { "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document Symbols" },
      { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Workspace Symbols" },
      { "<leader>lo", "<cmd>TSLspOrganizeSync<CR><cmd>lua vim.lsp.buf.format()<CR>", desc = "Organize all imports" },

      { "<leader>s", group = "Search" },
      { "<leader>sc", "<cmd>Telescope colorscheme<CR>", desc = "Colorscheme" },
      { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "Find Help" },
      { "<leader>sM", "<cmd>Telescope man_pages<CR>", desc = "Man Pages" },
      { "<leader>sr", "<cmd>Telescope oldfiles<CR>", desc = "Open Recent File" },
      { "<leader>sR", "<cmd>Telescope registers<CR>", desc = "Registers" },
      { "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
      { "<leader>sC", "<cmd>Telescope commands<CR>", desc = "Commands" },
      { "<leader>sp", "<cmd>lua require('telescope').extensions.projects.projects()<CR>", desc = "Projects" },
      { "<leader>st", "<cmd>Telescope live_grep theme=ivy<CR>", desc = "Find Text" },
      { "<leader>sl", "<cmd>Telescope resume<CR>", desc = "Resume telescope" },

      { "<leader>t", group = "Terminal" },
      { "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", desc = "Node" },
      { "<leader>tu", "<cmd>lua _NCDU_TOGGLE()<CR>", desc = "NCDU" },
      { "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<CR>", desc = "Htop" },
      { "<leader>tr", "<cmd>lua _RANGER_TOGGLE()<CR>", desc = "Ranger" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Float" },
      { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "Horizontal" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "Vertical" },
    })
  end,
}
