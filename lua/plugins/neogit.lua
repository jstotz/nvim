return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          local prefix = "<Leader>g"
          maps.n[prefix .. "g"] = { "<Cmd>Neogit<CR>", desc = "Open Neogit" }
        end,
      },
    },
    event = "User AstroGitFile",
    cmd = { "Neogit" },
    opts = function(_, opts)
      local utils = require("astrocore")
      local disable_builtin_notifications = utils.is_available("nvim-notify") or utils.is_available("noice.nvim")
      local ui_utils = require("astroui")
      local fold_signs = { ui_utils.get_icon("FoldClosed"), ui_utils.get_icon("FoldOpened") }

      return utils.extend_tbl(opts, {
        disable_builtin_notifications = disable_builtin_notifications,
        telescope_sorter = function()
          if utils.is_available("telescope-fzf-native.nvim") then
            return require("telescope").extensions.fzf.native_fzf_sorter()
          end
        end,
        integrations = { telescope = utils.is_available("telescope.nvim") },
        signs = { section = fold_signs, item = fold_signs },
      })
    end,
  },
  {
    "catppuccin/nvim",
    optional = true,
    ---@type CatppuccinOptions
    opts = { integrations = { neogit = true } },
  },
}
