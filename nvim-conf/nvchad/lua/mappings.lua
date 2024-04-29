require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "Format code" })

map("i", "jj", "<esc>")
map("i", "jk", "<esc>")

-- Manage linter
nomap("n", "]d")
nomap("n", "[d")
map("n", "]l", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "[l", "<cmd>lua vim.diagnostic.goto_prev()<CR>")

-- want to execute lines
map("n", "<leader>xx", '<cmd>exec "!".getline(".")<cr>', { desc = "Exec current line" })
map("n", "<leader>xc", '<cmd>exec ".!".getline(".")<cr>', { desc = "Exec and replace current line" })

-- want to format files
map("n", "<leader>j", "<cmd>.!python3 -m json.tool<cr>", { desc = "Format JSON" })
map("n", "<leader>p", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "format files" })

-- want to clear the search
nomap("n", "<leader>/")
map("n", "<leader>/", "<silent><cmd>let @/=''<cr>")

-- want to comment the right way
nomap("n", "<leader>cc")
map("n", "<leader>cc", "<Plug>(comment_toggle_linewise_count)")
map("n", "<leader>cs", "<Plug>(comment_toggle_blockwise_count)")
map("v", "<leader>cs", "<Plug>(comment_toggle_blockwise_visual)")

-- want to use leader f for ranger-like and move telescope elsewhere
map("n", "<leader>f", "<cmd>lua require('lf').start()<CR>", { desc = "open lf as file explorer" })
nomap("n", "<leader>fm")
nomap("n", "<leader>fa")
nomap("n", "<leader>fw")
nomap("n", "<leader>fb")
nomap("n", "<leader>ff")
nomap("n", "<leader>fh")
nomap("n", "<leader>fo")
nomap("n", "<leader>fz")
nomap("n", "<leader>pt")
map(
  "n",
  "<leader>ga",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)
map("n", "<leader>gb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>gf", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map("n", "<leader>gh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>gz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>gw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })

local nvim_tmux_nav = require "nvim-tmux-navigation"
map("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
map("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
map("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
map("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
