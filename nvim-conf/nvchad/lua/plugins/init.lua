local plugins = {
  {
    "folke/which-key.nvim",
    keys = function()
      return { "<leader>" }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
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
}

return plugins
