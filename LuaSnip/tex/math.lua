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
    { trig = ';e[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'math mode', priority = 500 },
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
    { trig = ';%B[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'braket', condition = in_mathzone },
    fmta([[(<>)]], {
      i(1),
    })
  ),
  s(
    { trig = ';BB[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'big braket', condition = in_mathzone },
    fmta([[\left(<>\right)]], {
      i(1),
    })
  ),
  s(
    { trig = ';V%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'square braket', condition = in_mathzone },
    fmta([[ [<>] ]], {
      i(1),
    })
  ),
  s(
    { trig = ';VV[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'big square braket', condition = in_mathzone },
    fmta([[ \left[<>\right] ]], {
      i(1),
    })
  ),
  s(
    { trig = ';{{[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'big curly braket', condition = in_mathzone },
    fmta([[ \left\{<>\right} ]], {
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
    fmta([[\int_{-\infty}^{\infty} <>]], {
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
  s(
    { trig = ';tt[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = '\\textrm', condition = in_mathzone },
    fmta([[\textrm{<>}]], {
      i(1),
    })
  ),
  s(
    { trig = ';lb[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = '\\label' },
    fmta([[\label{<>}]], {
      i(1),
    })
  ),
  s(
    { trig = ';bf[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = '\\bref' },
    fmta([[\bref{<>}]], {
      i(1),
    })
  ),
  s(
    { trig = ';kt[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = '\\ket', condition = in_mathzone },
    fmta([[\ket{<>}]], {
      i(1),
    })
  ),
  s(
    { trig = ';ba[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = '\\bra', condition = in_mathzone },
    fmta([[\bra{<>}]], {
      i(1),
    })
  ),
  s(
    { trig = ';sm[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'Summation', condition = in_mathzone },
    fmta([[\sum_{<>}^{<>}]], {
      i(1),
      i(2),
    })
  ),
  s(
    { trig = ';pd[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = 'Products', condition = in_mathzone },
    fmta([[\prod_{<>}^{<>}]], {
      i(1),
      i(2),
    })
  ),
  s(
    { trig = ';cl[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = '\\cal', condition = in_mathzone },
    fmta([[{\cal{<>}}]], {
      i(1),
    })
  ),
  s(
    { trig = ';br[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = '\\bar{}', condition = in_mathzone },
    fmta([[\bar{<>}]], {
      i(1),
    })
  ),
  s(
    { trig = ';ht[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = '\\hat{}', condition = in_mathzone },
    fmta([[\hat{<>}]], {
      i(1),
    })
  ),
  s(
    { trig = ';ti[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = '\\tilde{}', condition = in_mathzone },
    fmta([[\tilde{<>}]], {
      i(1),
    })
  ),
  s(
    { trig = ';dt[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = '\\dot{}', condition = in_mathzone },
    fmta([[\dot{<>}]], {
      i(1),
    })
  ),
  s(
    { trig = ';vc[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = '\\vec{}', condition = in_mathzone },
    fmta([[\vec{<>}]], {
      i(1),
    })
  ),
  s(
    { trig = ';ov[%s]', regTrig = true, wordTrig = false, snippetType = 'autosnippet', dscr = '\\overline{}', condition = in_mathzone },
    fmta([[\overline{<>}]], {
      i(1),
    })
  ),
}
return M
