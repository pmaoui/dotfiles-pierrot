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
  { "akinsho/toggleterm.nvim" },
  { "davvid/telescope-git-grep.nvim" },
  {
    "lmburns/lf.nvim",
    lazy = false,
    config = function()
      -- This feature will not work if the plugin is lazy-loaded
      vim.g.lf_netrw = 1
      require("nvchad.term")
      require("lf").setup {
        border = "rounded",
        winblend = 10, -- psuedotransparency level
        dir = "", -- directory where `lf` starts ('gwd' is git-working-directory, ""/nil is CWD)
        tmux = false, -- tmux statusline can be disabled on opening of Lf
        default_file_manager = false, -- make lf default file manager
        disable_netrw_warning = true, -- don't display a message when opening a directory with `default_file_manager` as true
      }
      vim.keymap.set("n", "<C-f>", "<Cmd>Lf<CR>")
    end,
    dependencies = { "toggleterm.nvim" },
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
    cmd = { 'BlameToggle', 'Gblame' },
    config = function()
      vim.cmd('command! Gblame BlameToggle')
      require("blame").setup()
    end
  },
  {
    "wren/jrnl.vim",
    lazy = false,
  },
}

return plugins
