return {
  "j-hui/fidget.nvim",
  keys = {
    { "<leader>fn", "<cmd>Fidget clear<cr>", desc = "Dismiss notifications" },
    { "<leader>fN", "<cmd>Fidget history<cr>", desc = "Notification history" },
  },
  opts = {
    notification = {
      override_vim_notify = true,
      window = {
        winblend = 0,
        relative = "editor",
        align = "bottom",
        x_padding = 1,
        y_padding = 0,
      },
      configs = {
        default = {
          ttl = 30, -- 30 seconds
        },
      },
    },
    progress = {
      display = {
        render_limit = 16,
        done_ttl = 30, -- 30 seconds
        done_icon = "✔",
        done_style = "Comment",
        progress_icon = { pattern = "dots", period = 1 },
      },
    },
  },
}
