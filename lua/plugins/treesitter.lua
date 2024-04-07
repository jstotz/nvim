-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "bash",
      "c",
      "css",
      "diff",
      "dockerfile",
      "git_rebase",
      "gitcommit",
      "gitignore",
      "graphql",
      "hcl",
      "html",
      "javascript",
      "json",
      "lua",
      "make",
      "markdown",
      "ruby",
      "sql",
      "tsx",
      "vim",
      "yaml",
    })
  end,
}
