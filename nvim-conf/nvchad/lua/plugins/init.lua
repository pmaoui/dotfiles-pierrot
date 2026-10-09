require "configs.bedrocks_env"

local plugins = {
  { import = "nvchad.blink.lazyspec" },
  {
    "folke/which-key.nvim",
    keys = function()
      return { "<leader>" }
    end,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "configs.gitsigns"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "git")
      require("gitsigns").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "html",
        "markdown",
        "javascript",
        "typescript",
        "go",
        "python",
        "json",
        "vimdoc",
      },
    },
  },
  { "alexghergh/nvim-tmux-navigation" },
  { "akinsho/toggleterm.nvim" },
  { "davvid/telescope-git-grep.nvim" },
  {
    "mikavilpas/yazi.nvim",
    version = "*", -- use the latest stable version
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      {
        "<leader>f",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
    },
    opts = {
      open_for_directories = true,
    },
    init = function()
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    opts = {
      mappings = false,
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "html-lsp",
        "prettier",
        "stylua",
        "pyright",
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },
  {
    "windwp/nvim-autopairs",
    enabled = false,
  },
  {
    "FabijanZulj/blame.nvim",
    cmd = { "BlameToggle", "Gblame" },
    config = function()
      vim.cmd "command! Gblame BlameToggle"
      require("blame").setup()
    end,
  },
  {
    "wren/jrnl.vim",
    lazy = false,
  },
}

return plugins
