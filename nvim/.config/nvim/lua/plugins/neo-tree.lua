return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  opts = {
    window = {
      insert_as = "sibling", -- insert nodes  as siblings of the directory under cursor
      mappings = {
        ["/"] = "", -- use default Neovim "/" search
        ["l"] = "open",
        ["h"] = "close_node",
      },
    },
    filesystem = {
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens within the window like netrw would, regardless of window.position
      -- enable libuv_file_watcher to see git status updates in Neo-tree on file write
      use_libuv_file_watcher = true, -- this will use the OS level file watchers to detect changes instead of relying on nvim autocmd events
      group_empty_dirs = true,
      filtered_items = {
        hide_by_name = {
          "node_modules",
          "yarn.lock",
          "package-lock.json",
          "README.md",
          "next-env.d.ts",
        },
      },
    },
  },
}
