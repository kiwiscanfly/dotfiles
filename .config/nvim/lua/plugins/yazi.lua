return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>e",
      "<cmd>Yazi<cr>",
      desc = "Open yazi file manager",
    },
    {
      "<leader>E",
      "<cmd>Yazi cwd<cr>",
      desc = "Open yazi (cwd)",
    },
  },
  opts = {
    -- Open yazi in a floating window
    open_for_directories = false,

    -- Keybindings inside yazi
    keymaps = {
      show_help = '<f1>',
      open_file_in_vertical_split = '<c-v>',
      open_file_in_horizontal_split = '<c-x>',
      open_file_in_tab = '<c-t>',
      grep_in_directory = '<c-s>',
      replace_in_directory = '<c-g>',
      cycle_open_buffers = '<tab>',
      copy_relative_path_to_selected_files = '<c-y>',
    },

    -- Integrate with Snacks picker for searching
    integrations = {
      grep_in_directory = function(directory)
        require("snacks").picker.grep({ cwd = directory })
      end,
    },

    -- Highlight open buffers in yazi (matches your purple theme)
    highlight_groups = {
      hovered_buffer = { bg = "#7c6f9f" },
    },
  },
}
