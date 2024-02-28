local M = {}

M.general = {
  n = {
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    }
  }
}

M.disabled = {
  n = {
    ["<C-h>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
    ["<C-l>"] = "",
  }
}

return M
