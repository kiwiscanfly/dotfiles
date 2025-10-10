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

    -- Explorer (file navigation)
    explorer = {
      enabled = true,
      replace_netrw = true,
      win = {
        style = {
          bg = "Normal",
        },
      },
    },

    -- Picker (find files/content)
    picker = { enabled = true },

    -- UI enhancements
    indent = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    animate = { enabled = true },

    -- Dashboard
    dashboard = {
      enabled = true,
      preset = {
        header = [[
 ██████╗ ██████╗ ██╗  ██╗ █████╗
 ██╔══██╗██╔══██╗██║ ██╔╝██╔══██╗
 ██████╔╝██████╔╝█████╔╝ ███████║
 ██╔══██╗██╔══██╗██╔═██╗ ██╔══██║
 ██║  ██║██████╔╝██║  ██╗██║  ██║
 ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝]],
      },
      sections = {
        { section = "header", hl = "SnacksDashboardHeader" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
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
    { "<leader>e", function() Snacks.explorer.open() end, desc = "Explorer (root)" },
    { "<leader>E", function() Snacks.explorer.open({ cwd = vim.fn.getcwd() }) end, desc = "Explorer (cwd)" },
    { "<leader>.", function() Snacks.picker.smart() end, desc = "Smart find" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find git files" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find buffers" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Find recent files" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sd", function() Snacks.dashboard() end, desc = "Dashboard" },
  },
}
