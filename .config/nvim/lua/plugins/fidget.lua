return {
  "j-hui/fidget.nvim",
  opts = {
    -- Configure notification subsystem
    notification = {
      window = {
        winblend = 0, -- Background transparency (0 = opaque)
        relative = "editor", -- Position relative to editor
        align = "bottom", -- Align to bottom of editor
        x_padding = 1, -- Horizontal padding
        y_padding = 0, -- Vertical padding
      },
      override_vim_notify = true, -- Use fidget for vim.notify()
      configs = {
        default = {
          ttl = 40, -- How long notifications stay (seconds)
        },
      },
    },
    -- Configure LSP progress subsystem
    progress = {
      display = {
        render_limit = 16, -- Max number of messages to display
        done_ttl = 20, -- How long to show completed LSP messages (seconds)
        done_icon = "✔", -- Icon for completed tasks
        done_style = "Comment", -- Highlight group for completed tasks
        progress_icon = { pattern = "dots", period = 1 }, -- Animated spinner
      },
    },
  },
}
