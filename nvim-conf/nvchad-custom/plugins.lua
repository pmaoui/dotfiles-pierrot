local plugins = {
  {
    "neovim/nvim-lspconfig",
     config = function()
        require "plugins.configs.lspconfig"
        require "custom.lspconfig"
     end,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require "custom.conform"
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
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>" },
      { "<C-j>" },
      { "<C-k>" },
      { "<C-l>" },
      { "<c-\\>" },
    },
  },
}

return plugins
