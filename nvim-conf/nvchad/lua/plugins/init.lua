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
    "lmburns/lf.nvim",
    lazy = false,
    init = function()
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
  {
    "yetone/avante.nvim",
    config = function()
      local command = [[
        aws sts assume-role \
          --role-arn arn:aws:iam::917060388293:role/PierreNeoVimAvanteBedrockRole \
          --role-session-name MySession \
          --region eu-west-3 \
          --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]' \
          --output text \
          | awk '{print $1","$2",eu-west-3,"$3}'
      ]]

      local handle = io.popen(command)
      if handle == nil then
        vim.notify("Failed to run AWS command", vim.log.levels.ERROR)
        return
      end

      local result = handle:read("*a")
      handle:close()

      result = result:gsub("%s+", "")
      if result == nil or result == "" then
        vim.notify("Failed to retrieve BEDROCK_KEYS", vim.log.levels.ERROR)
        return
      end

      vim.env.BEDROCK_KEYS = result
      vim.notify("BEDROCK_KEYS environment variable set", vim.log.levels.INFO)
    end,
    event = "VeryLazy",
    detachedHead = false,
    lazy = true,
    version = '*',
    opts = {
      provider = "bedrock",
      bedrock = {
        model = "eu.anthropic.claude-3-5-sonnet-20240620-v1:0"
      }
    },
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
}

return plugins
