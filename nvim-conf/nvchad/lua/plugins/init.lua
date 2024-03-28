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
        "vimdoc"
      },
    },
  },
  { 'alexghergh/nvim-tmux-navigation', lazy = false },
}

return plugins
