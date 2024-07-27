return {
  {
    "napmn/react-extract.nvim",
    config = function()
      local react_extract = require("react-extract")

      react_extract.setup()

      vim.keymap.set(
        { "v" },
        "<leader>re",
        require("react-extract").extract_to_new_file,
        { desc = "Extract to new file" }
      )
      vim.keymap.set(
        { "v" },
        "<leader>rc",
        require("react-extract").extract_to_current_file,
        { desc = "Extract to current file" }
      )
    end,
  },
}
