local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
j },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim"} -- Have packer manage itself
  use { "nvim-lua/plenary.nvim"} -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs"} -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim"}
  use { "JoosepAlviste/nvim-ts-context-commentstring"}
  use { "kyazdani42/nvim-web-devicons"}
  use { "kyazdani42/nvim-tree.lua"}
  use { "moll/vim-bbye"}
  use { "nvim-lualine/lualine.nvim"}
  use { "akinsho/toggleterm.nvim"}
  use { "ahmedkhalf/project.nvim"}
  use { "lewis6991/impatient.nvim"}
  use { "lukas-reineke/indent-blankline.nvim"}
  use { "goolord/alpha-nvim"}
  use {

    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  }
  use { "briones-gabriel/darcula-solid.nvim", requires = "rktjmp/lush.nvim" }
  -- use { "github/copilot.vim" }
  use { "christoomey/vim-tmux-navigator" }
  use { "sindrets/diffview.nvim" }

  -- Colorschemes
  use { "lunarvim/darkplus.nvim"}

  -- cmp plugins
  use { "hrsh7th/nvim-cmp"} -- The completion plugin
  use { "hrsh7th/cmp-buffer"} -- buffer completions
  use { "hrsh7th/cmp-path"} -- path completions
  use { "saadparwaiz1/cmp_luasnip"} -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp"}
  use { "hrsh7th/cmp-nvim-lua"}

  -- snippets
  use { "L3MON4D3/LuaSnip"} --snippet engine
  use { "rafamadriz/friendly-snippets"} -- a bunch of snippets to use

  -- LSP
  -- use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
  use { "neovim/nvim-lspconfig"} -- enable LSP
  use { "williamboman/mason.nvim"}
  use { "williamboman/mason-lspconfig.nvim"}
  -- use { "jose-elias-alvarez/null-ls.nvim"} -- broken, replaced with none-ls
  use { "nvimtools/none-ls.nvim" }
  use { "RRethy/vim-illuminate"}

  -- Telescope
  use { "nvim-telescope/telescope.nvim"}

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
  }

  -- Git
  use { "lewis6991/gitsigns.nvim"}
  use { "https://tpope.io/vim/fugitive.git"}
  use { "https://tpope.io/vim/rhubarb.git" }

  -- DAP
  use { "mfussenegger/nvim-dap"}
  use { "rcarriga/nvim-dap-ui"}
  use { "ravenxrz/DAPInstall.nvim"} -- maybe remove? can't find good support

  -- Debuggers
  use { "mfussenegger/nvim-dap-python" } -- Run/Debug a python app with launch.json
  -- use { "David-Kunz/jester" } -- Run/Debug Jest tests
  -- use { "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } } -- Run/Debug a node app
  -- use {
  --   "microsoft/vscode-js-debug",
  --   opt = true,
  --   run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  -- }

  -- Flutter
  use {
    "akinsho/flutter-tools.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
