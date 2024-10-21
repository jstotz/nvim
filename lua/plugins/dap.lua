-- Customize DAP (integrated debugger)

---@alias arg (fun(): string) | string

---@class (exact) dap.RubyConfiguration: dap.Configuration
---@field env nil|table<string, string>
---@field command string
---@field args arg[]

---@param args arg[]
---@return string[]
local function eval_args(args)
  local evaled_args = {}
  for i, value in ipairs(args) do
    if type(value) == "function" then
      evaled_args[i] = value()
    else
      evaled_args[i] = value
    end
  end
  return evaled_args
end

---@type LazySpec
return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "python",
        -- add more arguments for adding more debuggers
      })
    end,
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = { "jbyuki/one-small-step-for-vimkind" },
    config = function()
      local dap = require "dap"

      dap.adapters.ruby = function(callback, config)
        ---@cast config dap.RubyConfiguration

        local args = vim.list_extend({
          "exec",
          "rdbg",
          "-n",
          "--open",
          "--port",
          "${port}",
          "-c",
          "--",
          "bundle",
          "exec",
          config.command,
        }, eval_args(config.args))

        vim.notify(vim.inspect(args))

        callback {
          type = "server",
          host = "127.0.0.1",
          port = "${port}",
          executable = {
            command = "bundle",
            env = config.env,
            args = args,
          },
          options = {
            max_retries = 60,
          },
        }
      end

      dap.configurations.ruby = {
        {
          type = "ruby",
          name = "run rails server",
          request = "attach",
          localfs = true,
          command = "rails",
          env = {
            WEB_CONCURRENCY = "1",
            RAILS_MAX_THREADS = "1",
          },
          args = { "server" },
        },
        {
          type = "ruby",
          name = "run sidekiq",
          request = "attach",
          localfs = true,
          command = "sidekiq",
          args = {},
        },
        {
          type = "ruby",
          name = "run rails console",
          request = "attach",
          localfs = true,
          command = "rails",
          args = { "console" },
        },
        {
          type = "ruby",
          name = "run current spec file",
          request = "attach",
          localfs = true,
          command = "rspec",
          args = { "${file}" },
        },
        {
          type = "ruby",
          name = "run current spec line",
          request = "attach",
          localfs = true,
          command = "rspec",
          args = { function() return "${file}:" .. vim.fn.line "." end },
        },
        {
          type = "ruby",
          name = "debug current file",
          request = "attach",
          localfs = true,
          command = "ruby",
          args = { "${file}" },
        },
      } --[=[@as dap.RubyConfiguration[]]=]

      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }
      end
    end,
  },
}
