return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- Core utilities
    bigfile = { enabled = true },
    quickfile = { enabled = true },

    -- Image display (Kitty Graphics Protocol)
    image = {
      enabled = true,
      doc = {
        enabled = true,
        inline = false,
        float = true,
      },
      math = {
        enabled = true,
      },
    },

    -- Explorer (disabled - using yazi instead)
    explorer = {
      enabled = false,
    },

    -- Picker (find files/content)
    picker = {
      enabled = true,
      sources = {
        files = {
          hidden = true, -- Show hidden files by default
        },
      },
    },

    -- UI enhancements
    indent = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    animate = { enabled = true },

    -- Dashboard
    dashboard = {
      enabled = true,
      width = 70,
      preset = {
        header = [[
 ██████╗ ██████╗ ██╗  ██╗ █████╗
 ██╔══██╗██╔══██╗██║ ██╔╝██╔══██╗
 ██████╔╝██████╔╝█████╔╝ ███████║
 ██╔══██╗██╔══██╗██╔═██╗ ██╔══██║
 ██║  ██║██████╔╝██║  ██╗██║  ██║
 ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝]],
        keys = {
          { icon = "󰎔 ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = "󰈞 ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
          { icon = "󰙅 ", key = "e", desc = "File Manager", action = ":Yazi" },
          { icon = "󰱼 ", key = "g", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
          { icon = "󰒓 ", key = "c", desc = "Config", action = ":lua Snacks.picker.files({cwd = vim.fn.stdpath('config')})" },
          { icon = "󰩈 ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header", hl = "SnacksDashboardHeader", padding = 1 },
        { section = "keys", gap = 1, padding = 2, pane = 1 },
        { icon = "󰋚 ", title = "Recent Files\n", section = "recent_files", limit = 10, gap = 1, padding = 2, pane = 2 },
        { section = "startup", padding = 1 },
      },
    },

    -- Notifications
    notifier = {
      enabled = false,
      timeout = 3000,
    },

    -- Input dialogs
    input = { enabled = true },

    -- LSP reference highlighting
    words = { enabled = true },
  },
  keys = {
    { "<leader>.", function() Snacks.picker.smart() end, desc = "Smart find" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find git files" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find buffers" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Find recent files" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sd", function() Snacks.dashboard() end, desc = "Dashboard" },
    { "<leader>si", function() Snacks.image.hover() end, desc = "Image hover" },
  },
}
