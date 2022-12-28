
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Simple plugins can be specified as strings
  use 'rstacruz/vim-closer'
  
  -- You can alias plugin names
  use {'dracula/vim', as = 'dracula'} 

  -- telescope.nvim is a highly extendable fuzzy finder over lists.
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use ({'folke/tokyonight.nvim', as = 'tokyounight', config = function()
  	vim.cmd('colorscheme tokyonight-night')
	end
  })

  -- Tree-sitter is a parser generator tool and an incremental parsing library. 
  -- It can build a concrete syntax tree for a source file and efficiently
  -- update the syntax tree as the source file is edited.
  use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  -- Undotree visualizes the undo history and makes it easy to browse 
  -- and switch between different undo branches.
  -- Use :UndotreeToggle to toggle the undo-tree panel.
  use('mbbill/undotree')

  -- Fugitive is the premier Vim plugin for Git. Or maybe it's the premier
  -- Git plugin for Vim? Either way, it's "so awesome, 
  -- it should be illegal". That's why it's called Fugitive.
  -- The crown jewel of Fugitive is :Git (or just :G),
  -- which calls any arbitrary Git command. 
  use('tpope/vim-fugitive')

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }
  use("neovim/nvim-lspconfig")
  use("folke/zen-mode.nvim")
  use("github/copilot.vim")

  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

  use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }

  use { 'mg979/vim-visual-multi', branch = 'master' }
  use {'nvim-orgmode/orgmode', config = function()
    require('orgmode').setup{}
  end}
  use {'akinsho/org-bullets.nvim', config = function()
    require('org-bullets').setup()
  end,}
  use {
            'lukas-reineke/headlines.nvim',
            config = function()
                require('headlines').setup()
            end,
        }
   use { 'michaelb/sniprun', run = 'bash ./install.sh'}
   use { 'puremourning/vimspector',
    cmd = { "VimspectorInstall", "VimspectorUpdate" },
    fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
    config = function()
     require("config.vimspector").setup()
    end,
   }
   use {
    "folke/which-key.nvim",
    config = function()
        require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        }
    end
    }
end)
