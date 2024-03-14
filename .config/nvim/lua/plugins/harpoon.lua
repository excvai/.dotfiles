return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local keymap = vim.keymap

    keymap.set("n", "<A-a>", "<cmd>lua require('harpoon.mark').add_file()<cr>")
    keymap.set("n", "<A-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")

    -- Jump to marked files
    keymap.set("n", "<A-1>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
    keymap.set("n", "<A-2>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
    keymap.set("n", "<A-3>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
    keymap.set("n", "<A-4>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")

    -- Jump between next and previous marked files
    keymap.set("n", "<A-5>", "<cmd>lua require('harpoon.ui').nav_next()<cr>")
    keymap.set("n", "<A-6>", "<cmd>lua require('harpoon.ui').nav_prev()<cr>")
  end,
}
