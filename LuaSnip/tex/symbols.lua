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

M = {}

local greek_lower = {
  a = 'alpha',
  b = 'beta',
  g = 'gamma',
  d = 'delta',
  e = 'epsilon',
  z = 'zeta',
  y = 'eta',
  h = 'theta',
  i = 'iota',
  k = 'kappa',
  l = 'lambda',
  m = 'mu',
  n = 'nu',
  c = 'xi',
  o = 'omicron',
  p = 'pi',
  r = 'rho',
  s = 'sigma',
  t = 'tau',
  u = 'upsilon',
  f = 'phi',
  x = 'chi',
  q = 'psi',
  w = 'omega',
}

local greek_upper = {
  G = 'Gamma',
  D = 'Delta',
  Z = 'Zeta',
  Y = 'Eta',
  H = 'Theta',
  I = 'Iota',
  K = 'Kappa',
  L = 'Lambda',
  M = 'Mu',
  N = 'Nu',
  C = 'Xi',
  P = 'Pi',
  S = 'Sigma',
  F = 'Phi',
  X = 'Chi',
  Q = 'Psi',
  W = 'Omega',
}
local greek_snips = {}

for dig, name in pairs(greek_lower) do
  local trig = ';' .. dig .. '[%s]'
  table.insert(
    greek_snips,
    s(
      { trig = trig, wordTrig = false, regTrig = true, priority = 2000, snippetType = 'autosnippet', dscr = '\\' .. name, condition = in_mathzone },
      t { '\\' .. name .. ' ' }
    )
  )
end

for dig, name in pairs(greek_upper) do
  local trig = ';' .. dig .. '[%s]'
  table.insert(
    greek_snips,
    s(
      { trig = trig, wordTrig = false, regTrig = true, priority = 2000, snippetType = 'autosnippet', dscr = '\\' .. name, condition = in_mathzone },
      t { '\\' .. name .. ' ' }
    )
  )
end

vim.list_extend(M, greek_snips)

local symbol_spec = {
  -- operators
  nq = [[\neq]],
  lq = [[\leq]],
  gq = [[\geq]],
  ll = [[\ll]],
  gg = [[\gg]],
  si = [[\sim]],
  ax = [[\approx]],
  siq = [[\simeq]],
  bsq = [[\backsimeq]],
  ev = [[\equiv]],
  cg = [[\cong]],
  def = [[\definedas]],
  ct = [[\cdot]],
  cts = [[\cdots]],
  ts = [[\times]],
  op = [[\oplus]],
  ot = [[\otimes]],
  --maths
  NN = [[\mathbb{N}]],
  ZZ = [[\mathbb{Z}]],
  QQ = [[\mathbb{Q}]],
  RR = [[\mathbb{R}]],
  CC = [[\mathbb{C}]],
  OO = [[\emptyset]],
  cc = [[\subset]],
  cq = [[\subseteq]],
  qq = [[\supset]],
  qc = [[\supseteq]],
  Nn = [[\cap]],
  UU = [[\cup]],

  --arrows
  ra = [[\rightarrow]],
  Ra = [[\Rightarrow]],
  mpt = [[\mapsto]],
  la = [[\leftarrow]],
  La = [[\Leftarrow]],
  lra = [[\longrightarrow]],
  Lra = [[\Longrightarrow]],
  lla = [[\longleftarrow]],
  Lla = [[\Longleftarrow]],
  LrA = [[\leftrightarrow]],
  LRA = [[\Leftrightarrow]],
  oo = [[\infty]],
  el = [[\ell]],
  dg = [[\dagger]],
  pm = [[\pm]],
  mp = [[\mp]],
  qu = [[\quad]],
  en = [[\enspace]],
  lg = [[\langle]],
  rg = [[\rangle]],
}

local symbol_snips = {}

for dig, name in pairs(symbol_spec) do
  local trig = ';' .. dig .. '[%s]'
  table.insert(
    symbol_snips,
    s({ trig = trig, wordTrig = false, regTrig = true, priority = 1000, snippetType = 'autosnippet', condition = in_mathzone, dscr = name }, t(name .. ' '))
  )
end

vim.list_extend(M, symbol_snips)

return M
