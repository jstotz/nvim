local function strip_ansi_escape_sequences(str)
  -- ANSI escape sequences start with the ESC character (27/0x1B) followed by '[',
  -- then have zero or more characters in the range of 40–47 (0x28–0x2F),
  -- followed by one or more characters in the range of 64–126 (0x40–0x7E).
  -- This pattern matches such sequences for removal.
  local ansiPattern = "\027[%[%d;]*%d*m"
  return (str:gsub(ansiPattern, ""))
end

return {
  {
    "nvim-neotest/neotest",
    ft = { "go", "ruby", "rust", "python" },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-python",
      "olimorris/neotest-rspec",
      "rouge8/neotest-rust",
      {
        "folke/neodev.nvim",
        opts = function(_, opts)
          opts.library = opts.library or {}
          if opts.library.plugins ~= true then
            opts.library.plugins = require("astronvim.utils").list_insert_unique(opts.library.plugins, "neotest")
          end
          opts.library.types = true
        end,
      },
    },
    opts = function()
      return {
        -- your neotest config here
        adapters = {
          require("neotest-go"),
          require("neotest-rspec"),
          require("neotest-rust"),
          require("neotest-python"),
        },
      }
    end,
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return strip_ansi_escape_sequences(message)
          end,
        },
      }, neotest_ns)
      require("neotest").setup(opts)
    end,
    keys = {
      { "<leader>Tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>TT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
      { "<leader>Tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>Tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
      {
        "<leader>Tf",
        function() require("neotest").run.run({ suite = false, status = "failed" }) end,
        desc = "Run Failed",
      },
      { "<leader>Ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      {
        "<leader>To",
        function() require("neotest").output.open({ enter = true, auto_close = true }) end,
        desc = "Show Output",
      },
      { "<leader>TO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>TS", function() require("neotest").run.stop() end, desc = "Stop" },
    },
  },
  {
    "catppuccin/nvim",
    optional = true,
    ---@type CatppuccinOptions
    opts = { integrations = { neotest = true } },
  },
}
