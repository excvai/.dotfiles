local ls = require("luasnip")

local p = ls.parser.parse_snippet

local ecma_react_typescript_snippets = {
  p(":fc", ": React.FC<$0Props>"),
}

ls.add_snippets("typescriptreact", ecma_react_typescript_snippets)
