return {
  {
    "napmn/react-extract.nvim",
    config = function()
      local status_ok, react_extract = pcall(require, "react-extract")
      if not status_ok then
        vim.notify("react-extract require failed")
        return
      end

      react_extract.setup()

      vim.keymap.set({ "v" }, "<Leader>re", require("react-extract").extract_to_new_file)
      vim.keymap.set({ "v" }, "<Leader>rc", require("react-extract").extract_to_current_file)
    end,
  },
}
