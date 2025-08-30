return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "v3.35",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true, -- Close Neo-tree if it's the last window
      popup_border_style = "rounded",
      filesystem = {
        filtered_items = {
          visible = false, -- Show hidden files
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true, -- Highlight current file
        },
        use_libuv_file_watcher = true, -- Auto-refresh on file changes
      },
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["<space>"] = "none", -- Disable space in Neo-tree since it's your leader
          ["<2-LeftMouse>"] = "open",
          ["<RightMouse>"] = "open_split",
        },
      },
      enable_git_status = true,
      enable_diagnostics = true,
    })
  end,
}
