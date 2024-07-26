return {
  "mattn/emmet-vim",
  enabled = false,
  -- Specify user_emmet_mode variable on startup. It won't work inside a config function
  init = function()
    vim.api.nvim_set_var("user_emmet_mode", "i") -- only enable insert mode functions
  end,
  config = function()
    -- Specify custom snippet for `!`
    vim.cmd([[
      let g:user_emmet_settings = {
      \  'variables': {'lang': 'en'},
      \  'html': {
      \    'default_attributes': {
      \      'option': {'value': v:null},
      \      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
      \    },
      \    'snippets': {
      \      'html:5': "<!DOCTYPE html>\n"
      \              ."<html lang=\"${lang}\">\n"
      \              ."<head>\n"
      \              ."\t<meta charset=\"${charset}\">\n"
      \              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
      \              ."\t<title></title>\n"
      \              ."</head>\n"
      \              ."<body>\n\t${child}|\n</body>\n"
      \              ."</html>",
      \    },
      \  },
      \}
    ]])
  end,
}
