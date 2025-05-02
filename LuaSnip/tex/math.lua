local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep

local function in_mathzone()
  return vim.api.nvim_eval 'vimtex#syntax#in_mathzone()' == 1
end

M = {

  s(
    { trig = ';ff[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', condition = in_mathzone, dscr = 'fraction' },
    fmta([[\frac{<>}{<>}]], {
      i(1),
      i(2),
    })
  ),
  s(
    { trig = ';(%d+)%/(%d+)[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', condition = in_mathzone, dscr = 'numerical fraction' },
    f(function(_, snip)
      local a, b = snip.captures[1], snip.captures[2]
      return '\\frac{' .. a .. '}{' .. b .. '}'
    end, {})
  ),
  s(
    { trig = ';;[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'inline math mode' },
    fmta([[$<>$]], {
      i(1),
    })
  ),
  s(
    { trig = ';e[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'math mode', priority = 2000 },
    fmta(
      [[ 
      \[ 
          <>
      \] 
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    { trig = ';%([%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'braket', condition = in_mathzone },
    fmta([[(<>)]], {
      i(1),
    })
  ),
  s(
    { trig = ';%(%([%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'big braket', condition = in_mathzone },
    fmta([[\left(<>\right)]], {
      i(1),
    })
  ),
  s(
    { trig = ';%[[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'square braket', condition = in_mathzone },
    fmta([[ [<>] ]], {
      i(1),
    })
  ),
  s(
    { trig = ';%[%[[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'big square braket', condition = in_mathzone },
    fmta([[ \left[<>\right] ]], {
      i(1),
    })
  ),
  s(
    { trig = ';{{[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'big curly braket', condition = in_mathzone },
    fmta([[ \left{<>\right} ]], {
      i(1),
    })
  ),
  s(
    { trig = '%^[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'superscript', condition = in_mathzone },
    fmta([[^{<>}]], {
      i(1),
    })
  ),
  s(
    { trig = '_[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'subscript', condition = in_mathzone },
    fmta([[_{<>}]], {
      i(1),
    })
  ),
  s(
    { trig = ';in[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'indefinite integral', condition = in_mathzone },
    fmta([[\int <>]], {
      i(1),
    })
  ),
  s(
    { trig = ';inf[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'definite integral1', condition = in_mathzone },
    fmta([[\int_{\infty}^{\infty} <>]], {
      i(1),
    })
  ),
  s(
    { trig = ';int[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'definite integral2', condition = in_mathzone },
    fmta([[\int_{<>}^{<>} <>]], {
      i(1),
      i(2),
      i(3),
    })
  ),
  s(
    { trig = ';eq[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'equation enviroment' },
    fmta(
      [[
      \begin{equation}
      <>
      \end{equation}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    { trig = ';gt[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'gather* enviroment' },
    fmta(
      [[
      \begin{gather*}
      <>
      \end{gather*}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    { trig = ';al[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'align* enviroment' },
    fmta(
      [[
      \begin{align*}
      <>
      \end{align*}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    { trig = ';cs[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'cases enviroment' },
    fmta(
      [[
      \begin{cases}
      <>
      \end{cases}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    { trig = ';env[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'cases enviroment' },
    fmta(
      [[
      \begin{<>}
      <>
      \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1),
      }
    )
  ),
}
return M
