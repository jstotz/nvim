return {
  "nvim-neotest/neotest",
  ft = { "ruby" },
  dependencies = { "olimorris/neotest-rspec" },
  opts = function(_, opts)
    if not opts.adapters then opts.adapters = {} end
    table.insert(opts.adapters, require "neotest-rspec")
  end,
}
