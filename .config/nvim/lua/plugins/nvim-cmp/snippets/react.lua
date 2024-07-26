local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt")

local s = ls.snippet
local p = ls.parser.parse_snippet
local i = ls.insert_node
local f = ls.function_node

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
  return args[1]
end

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
  p("cn", 'className="$0"')
}

ls.add_snippets("javascriptreact", ecma_react_snippets)
ls.add_snippets("typescriptreact", ecma_react_snippets)
