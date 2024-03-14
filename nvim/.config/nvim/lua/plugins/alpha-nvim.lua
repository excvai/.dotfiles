return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
      [[       ,.,                           ]],
      [[      MMMM_    ,..,                  ]],
      [[        "_ "__"MMMMM          ,...,, ]],
      [[ ,..., __." --"    ,.,     _-"MMMMMMM]],
      [[MMMMMM"___ "_._   MMM"_."" _ """"""  ]],
      [[ """""    "" , \_.   "_. ."          ]],
      [[        ,., _"__ \__./ ."            ]],
      [[       MMMMM_"  "_    ./             ]],
      [[        ''''      (    )             ]],
      [[ ._______________.-'____"---._.      ]],
      [[  \                          /       ]],
      [[   \________________________/        ]],
      [[   (_)                    (_)        ]],
      [[                                     ]],
    }
    dashboard.section.header.opts.hl = "Include"

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
      dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("p", "  Projects", ":Telescope projects <CR>"),
      dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
      dashboard.button("s", "  Restore Session", ":lua require('persistence').load() <CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }
    dashboard.section.buttons.opts.hl = "Keyword"

    -- Set footer
    dashboard.section.footer.val = "OwO"
    dashboard.section.footer.opts.hl = "Type"

    -- Send config to alpha
    alpha.setup(dashboard.opts)
  end,
}
