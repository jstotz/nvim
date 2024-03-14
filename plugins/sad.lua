return {
  "ray-x/sad.nvim",
  dependencies = { { "ray-x/guihua.lua", build = "cd lua/fzy && make" } },
  cmd = "Sad",
  keys = {
    { "<leader>fR", "<cmd>Sad<cr>", desc = "Find and replace in project" },
  },
  config = function() require("sad").setup({}) end,
}
