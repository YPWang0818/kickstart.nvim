-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Setup lazy.nvim
require('lazy').setup {
  spec = {
    {
      'lervag/vimtex',
      lazy = false, -- we don't want to lazy load VimTeX
      -- tag = "v2.15", -- uncomment to pin to a specific release
      init = function()
        -- VimTeX configuration goes here, e.g.
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_compiler_latexmk = { ['continuous'] = 0 }
      end,
    }, -- add your plugins here
    {
      'L3MON4D3/LuaSnip',
      -- follow latest release.
      version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = 'make install_jsregexp',
      config = function()
        local ls = require 'luasnip'

        vim.keymap.set({ 'i', 's' }, '<C-K>', function()
          ls.expand()
        end, { silent = true })
        vim.keymap.set({ 'i', 's' }, '<C-L>', function()
          ls.jump(1)
        end, { silent = true })
        vim.keymap.set({ 'i', 's' }, '<C-J>', function()
          ls.jump(-1)
        end, { silent = true })

        vim.keymap.set({ 'i', 's' }, '<C-E>', function()
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end, { silent = true })

        require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/LuaSnip/' }
        ls.config.setup { { enable_autosnippets = true } }
      end,
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { 'habamax' } },
  -- automatically check for plugin updates
  checker = { enabled = true },
}
