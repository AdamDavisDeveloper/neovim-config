-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return require('packer').startup(function(use)
  use("wbthomason/packer.nvim")
  -- old theme: use("bluz71/vim-nightfly-guicolors")
  --use("oxfist/night-owl.nvim")
  --use("rebelot/kanagawa.nvim")
  --use { "ellisonleao/gruvbox.nvim" }
  use { "AlexvZyl/nordic.nvim" }

  -- lua functions used by many plugins
  use("nvim-lua/plenary.nvim")
  use("EdenEast/nightfox.nvim")
  use("christoomey/vim-tmux-navigator")
  use("szw/vim-maximizer") -- maximizes and restores active window split
  -- essential plugins
  use("tpope/vim-surround") -- "<action> + s + <motion>" to surround text and do something
  use("vim-scripts/ReplaceWithRegister") -- normal mode - "gr + <motion>" to replace with copied text

  -- commenting with gc
  use("numToStr/Comment.nvim")

  -- file explorer
  use("nvim-tree/nvim-tree.lua")

  -- icons
  use("kyazdani42/nvim-web-devicons")

  -- statusline
  use("nvim-lualine/lualine.nvim")

  -- telescope fuzzyfinder
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

  -- Dashboard
  use { 'nvimdev/dashboard-nvim', event = 'VimEnter' } 

  use { "folke/zen-mode.nvim" }

  -- use("hrsh7th/nvim-cmp")
  -- use("hrsh7th/cmp-buffer")
  -- use("hrsh7th/cmp-path")


  -- full autocomplete
  use {
  'neovim/nvim-lspconfig', -- LSP
  'hrsh7th/nvim-cmp', -- Autocompletion plugin
  'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
  'hrsh7th/cmp-buffer', -- Buffer source for nvim-cmp
  'hrsh7th/cmp-path', -- Path completions
  'hrsh7th/cmp-cmdline', -- Command line completions
  'saadparwaiz1/cmp_luasnip', -- Snippet completions
  'L3MON4D3/LuaSnip', -- Snippet engine
  'onsails/lspkind-nvim', -- Icons for completions
  }

  -- snippets
  use {
    'L3MON4D3/LuaSnip', 
    config = function() require('luasnip.loaders.from_vscode').lazy_load() end
  }
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  })

  -- auto closing and pairs
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup {}
    end
  }
  use("windwp/nvim-ts-autotag")

  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
