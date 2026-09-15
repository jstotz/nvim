-- Keep aligned with the Herdr sidebar plugin in dotfiles.
return {
  "ChmaraX/herdr-nvim",
  commit = "0450dc7b4c40c986052541c00dba5cdcd1be7ac6",
  -- The sidebar calls setup() again on VimEnter. Let Lazy own the mappings
  -- so repeated setup does not warn about the plugin's own existing shortcuts.
  opts = { keymaps = false },
  keys = {
    { "<leader>ac", function() require("herdr-nvim").comment_line() end, desc = "herdr-nvim: comment line" },
    { "<leader>ac", function() require("herdr-nvim").comment_selection() end, mode = "x", desc = "herdr-nvim: comment selection" },
    { "<leader>al", function() require("herdr-nvim").list_comments() end, desc = "herdr-nvim: list comments" },
    { "<leader>as", function() require("herdr-nvim").send_all({ submit = false }) end, desc = "herdr-nvim: paste comments to agent" },
    { "<leader>aS", function() require("herdr-nvim").send_all({ submit = true }) end, desc = "herdr-nvim: send comments to agent" },
  },
  init = function()
    -- The sidebar daemon survives toggling, but its UI gets a new Herdr pane.
    -- Match the attached UI's PID rather than trusting focus or the old ID.
    local function refresh_pane(chan)
      if vim.env.HERDR_ENV ~= "1" then return end
      local client = vim.api.nvim_get_chan_info(chan).client or {}
      local pid = (client.attributes or {}).pid
      if client.name ~= "nvim-tui" or not pid then return end
      local function query(args)
        local command = { vim.env.HERDR_BIN_PATH or "herdr" }
        vim.list_extend(command, args)
        local result = vim.system(command, { text = true }):wait(2000)
        if result.code ~= 0 then return end
        local ok, decoded = pcall(vim.json.decode, result.stdout)
        if ok then return decoded.result end
      end
      local result = query({ "pane", "list", "--workspace", vim.env.HERDR_WORKSPACE_ID })
      for _, pane in ipairs(result and result.panes or {}) do
        if pane.tab_id == vim.env.HERDR_TAB_ID then
          local info = query({ "pane", "process-info", "--pane", pane.pane_id })
          for _, process in ipairs(info and info.process_info.foreground_processes or {}) do
            if process.pid == pid then
              vim.env.HERDR_PANE_ID = pane.pane_id
              return
            end
          end
        end
      end
    end
    vim.api.nvim_create_autocmd("UIEnter", {
      group = vim.api.nvim_create_augroup("HerdrSidebarPaneIdentity", { clear = true }),
      callback = function()
        local chan = vim.v.event.chan
        vim.schedule(function() refresh_pane(chan) end)
      end,
    })
    for _, ui in ipairs(vim.api.nvim_list_uis()) do refresh_pane(ui.chan) end
  end,
}
