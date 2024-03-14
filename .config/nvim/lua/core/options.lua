-- Set options
local options = {
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines

  -- Use two spaces indentation
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,

  smartindent = true,

  wrap = false,

  swapfile = false,
  undofile = true,

  termguicolors = true,

  scrolloff = 4,
  sidescrolloff = 4,

  timeoutlen = 500, -- time in milliseconds to wait for a mapped sequence to complete
  updatetime = 300, -- faster completion

  clipboard = "unnamed,unnamedplus", -- allows neovim to access the system clipboard

  showmode = false, -- disable because we have lualine

  ignorecase = true, -- ignore case in search patterns
  smartcase = true, -- smart case

  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window

  numberwidth = 3,
  signcolumn = "yes", -- always show the sign(ex. ) column, otherwise it would shift the text each time

  showtabline = 2, -- always show tabs

  fillchars = vim.opt.fillchars:append({ eob = " " }), -- remove the ~ symbol on lines without number

  mouse = "a", -- enable mouse
  mousemodel = "extend",

  pumheight = 10, -- pop up menu height

  cursorline = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Set variables
local variables = {
  html_no_rendering = 1, -- disable html tags rendering (check :help html.vim)
  -- Disable providers to improve startup time
  loaded_node_provider = 0,
  loaded_python3_provider = 0,
}

for k, v in pairs(variables) do
  vim.api.nvim_set_var(k, v)
end

-- Disable some builtin vim plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(default_plugins) do
  vim.g["loaded_" .. plugin] = 1
end
