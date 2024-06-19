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

-- want to comment the right way (with cc that can handle count correctly)
nomap("n", "<leader>cc")
map("n", "<leader>cc", function()
  return vim.v.count1 > 1 and "<Plug>(comment_toggle_linewise_count)" or "<Plug>(comment_toggle_linewise_current)"
end, { expr = true })
map("n", "<leader>cs", "<Plug>(comment_toggle_blockwise_count)")
map("v", "<leader>cs", "<Plug>(comment_toggle_blockwise_visual)")

-- want to use leader f for lf and move telescope elsewhere
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
map("n", "<F3>", "<cmd>Telescope git_grep grep<CR>", { desc = "telescope git grep current word" })

local nvim_tmux_nav = require "nvim-tmux-navigation"
map("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
map("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
map("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
map("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
