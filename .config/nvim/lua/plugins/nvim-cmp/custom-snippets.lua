local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt")

local s = ls.snippet
local p = ls.parser.parse_snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
  return args[1]
end

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

local ecma_react_snippets = {
  s(
    "usest",
    fmt.fmta("const [<>, <>] = useState(<>);", {
      i(1),
      f(function(args)
        return "set" .. args[1][1]:sub(1, 1):upper() .. args[1][1]:sub(2)
      end, 1),
      i(0),
    })
  ),
  s(
    "rms",
    fmt.fmt(
      [[
    import {{ {}, {}Props }} from '@mui/material';
    import {{ styled }} from '@mui/system';

    export const {} = styled({})<{}Props>({{
      {}
    }});
    ]],
      {
        f(copy, 2),
        f(copy, 2),
        i(1),
        i(2),
        f(copy, 2),
        i(0),
      }
    )
  ),
  p("rmis", "import { styled } from '@mui/material/styles';"),
  p("rfc", "\nexport const ${TM_FILENAME_BASE} = () => {\n\treturn (\n\t\t$0\n\t)\n}"),
  p("trans", "const { t } = useTranslation$0();"),
}
ls.add_snippets("javascriptreact", ecma_react_snippets)
ls.add_snippets("typescriptreact", ecma_react_snippets)

local ecma_react_typescript_snippets = {
  p(":fc", ": React.FC<$0Props>"),
}
ls.add_snippets("typescriptreact", ecma_react_typescript_snippets)
