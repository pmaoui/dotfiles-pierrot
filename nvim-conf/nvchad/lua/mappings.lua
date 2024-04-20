require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "Format code" })

map("i", "jj", "<esc>")
map("i", "jk", "<esc>")

-- want to execute lines
map("n", "<leader>xx", '<cmd>exec "!".getline(".")<cr>', { desc = "Exec current line" })
map("n", "<leader>xc", '<cmd>exec ".!".getline(".")<cr>', { desc = "Exec and replace current line" })

-- want to parse json
map("n", "<leader>fj", "<cmd>.!python3 -m json.tool<cr>", { desc = "Format JSON" })

-- want to clear the search
nomap("n", "<leader>/")
map("n", "<leader>/", "<silent><cmd>let @/=''<cr>")

local nvim_tmux_nav = require "nvim-tmux-navigation"
map("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
map("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
map("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
map("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
