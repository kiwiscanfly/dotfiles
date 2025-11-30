return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>sm", function() require("noice").cmd("history") end, desc = "Message history" },
  },
  config = function()
    require("noice").setup({
      -- Notifications handled by fidget
      notify = {
        enabled = false,
      },
      lsp = {
        progress = {
          enabled = false, -- Handled by fidget
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      views = {
        mini = {
          timeout = 30000, -- 30 seconds
        },
        split = {
          close = {
            keys = { "q", "<esc>" },
          },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    })
  end,
}
