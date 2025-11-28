return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    legacy_commands = false,

    workspaces = {
      {
        name = "notes",
        path = "~/repos/notes",
      },
    },

    -- Disable UI - render-markdown.nvim handles this
    ui = { enable = false },

    -- Note settings
    notes_subdir = nil,  -- Notes in root of vault
    new_notes_location = "current_dir",

    -- Daily notes
    daily_notes = {
      folder = "Journal",
      date_format = "%Y-%m-%d",
      template = nil,
    },

    -- Completion
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    -- Wiki links
    wiki_link_func = "use_alias_only",
    preferred_link_style = "wiki",

    -- Image pasting
    attachments = {
      img_folder = "assets",
    },

    -- Picker (uses snacks.picker since you have it)
    picker = {
      name = "snacks.picker",
    },
  },
  keys = {
    { "<leader>oo", "<cmd>Obsidian quick_switch<cr>", desc = "Find note" },
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New note" },
    { "<leader>od", "<cmd>Obsidian today<cr>", desc = "Daily note" },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
    { "<leader>ot", "<cmd>Obsidian tags<cr>", desc = "Tags" },
    { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search vault" },
    { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Links in note" },
    { "<leader>or", "<cmd>Obsidian rename<cr>", desc = "Rename note" },
  },
}
