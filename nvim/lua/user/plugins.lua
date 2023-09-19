local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').reset()
require('packer').init({
  compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
  display = {
    open_fn = function()
      return require('packer.util').float({border = 'solid'})
    end,
  },
})

local use = require('packer').use

use('wbthomason/packer.nvim')

use('tpope/vim-commentary')

use('tpope/vim-surround')

use('tpope/vim-eunuch')

use('tpope/vim-unimpaired')

use('tpope/vim-sleuth')

use('tpope/vim-repeat')

use('sheerun/vim-polyglot')

use('farmergreg/vim-lastplace')

use('nelstrom/vim-visual-star-search')

use('jessarcher/vim-heritage')

use({
  'whatyouhide/vim-textobj-xmlattr',
  requires = 'kana/vim-textobj-user',

})

use('christoomey/vim-tmux-navigator')
use({
  'airblade/vim-rooter',
  setup= function()
    vim.g.rooter_manual_only = 1
  end,
  config = function()
    vim.cmd('Rooter')
  end,

})

use({
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup()
  end,

})

use({
  'karb94/neoscroll.nvim',
  config = function()
    require('neoscroll').setup()
  end,
})

use({
  'famiu/bufdelete.nvim',
  config = function()
    vim.keymap.set('n', '<Leader>q', ':Bdelete<CR>')
  end,
})

use({
  'AndrewRadev/splitjoin.vim',
  config = function()
    vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
    vim.g.splitjoin_trailing_comma = 1
    vim.g.splitjoin_php_method_chain_full = 1
  end,
})

use({
  'sickill/vim-pasta',
  config = function()
    vim.g.pasta_disabled_filetypes = { 'fugitive' }
  end,
})



use({
    'jessarcher/onedark.nvim',
    config = function()
      vim.cmd('colorscheme onedark')

      vim.api.nvim_set_hl(0, 'FloatBorder',{
        fg=vim.api.nvim_get_hl_by_name('NormalFloat', true).background,

        bg=vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
      })  
  end,
  })

use('liuchengxu/vim-which-key')


use ({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'nvim-telescope/telescope-live-grep-args.nvim',
      {'nvim-telescope/telescope-fzf-native.nvim', run= 'make' },
    },
    config= function()
      require('user/plugins/telescope')
    end,
  })


use({
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user/plugins/nvim-tree')
    end,
  })


use({
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('lualine').setup()
    end,
  })

use({
  'glepnir/dashboard-nvim',
  config = function()
    require('user.plugins.dashboard')
  end,
})

use({
    'akinsho/bufferline.nvim',
    requires= 'kyazdani42/nvim-web-devicons',
    after= 'onedark.nvim',
    config=function()
      require('user/plugins/bufferline')
    end,
  })
use({
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require('user/plugins/indent-blankline')
  end,
})
-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
  require('packer').sync()
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>  
  augroup end
]])

use({
    'tpope/vim-fugitive',
    requires = 'tpope/vim-rhubarb',
  })

use({
  'lewis6991/gitsigns.nvim',
  requires = 'nvim-lua/plenary.nvim',
  config = function()
    require('gitsigns').setup({
      sign_priority = 20,
      on_attach = function(bufnr)
        vim.keymap.set('n', 'ùh', "&diff ? 'ùc' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true, buffer = bufnr })
        vim.keymap.set('n', '$h', "&diff ? '$c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true, buffer = bufnr })
      end,
    })
  end,
})
use({
    'voldikss/vim-floaterm',

    config = function()
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
      vim.keymap.set('n','<F1>',':FloatermToggle<CR>')
      vim.keymap.set('t','<F1>','<C-\\><C-n>:FloatermToggle<CR>')
      vim.cmd([[
        highlight link Floaterm CursorLine
        highlight link FloatermBorder CursorLineBg
        
      ]]) 
    end
  })


use({
  'nvim-treesitter/nvim-treesitter',
  run = function()
    require('vim-treesitter.install').update({with_sync = true })
  end,
config = function()
    require('user.plugins.treesitter')
  end,
})


