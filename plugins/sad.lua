return {
  "ray-x/sad.nvim",
  dependencies = { { "ray-x/guihua.lua", build = "cd lua/fzy && make" } },
  event = "VeryLazy",
  config = function() require("sad").setup({}) end,
}
