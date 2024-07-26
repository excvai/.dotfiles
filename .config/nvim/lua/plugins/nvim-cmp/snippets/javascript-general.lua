local ls = require("luasnip")

local p = ls.parser.parse_snippet

local ecma_snippets = {
  p("testsn", "const $1 = {\n  $0\n}"), -- snippet for testing purposes
  p("cl", "console.log($0)"),
  p(">", "($2) => {\n\t$1\n}"),
  p("todo", "// TODO: "),
}

ls.add_snippets("javascript", ecma_snippets)
ls.add_snippets("javascriptreact", ecma_snippets)
ls.add_snippets("typescript", ecma_snippets)
ls.add_snippets("typescriptreact", ecma_snippets)
