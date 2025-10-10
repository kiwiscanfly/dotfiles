return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {
        mocha = {
          base = "#171312",
        },
      },
      custom_highlights = function(colors)
        return {
          Cursor = { bg = colors.red, fg = colors.base },
          lCursor = { bg = colors.red, fg = colors.base },
          CursorLine = { bg = colors.surface0 },

          -- Explorer/Sidebar - neutral background with peach accents
          NormalFloat = { bg = colors.base },
          FloatBorder = { bg = colors.base, fg = colors.surface0 },

          -- Snacks explorer specific
          SnacksNormal = { bg = colors.base },
          SnacksBorder = { bg = colors.base, fg = colors.surface0 },

          -- Directory and file selection - peach accents
          Directory = { fg = colors.text },
          SnacksIndent = { fg = colors.surface1 },
          SnacksIndentScope = { fg = "#d99368" }, -- peach accent

          -- Selected/cursor items
          PmenuSel = { bg = colors.surface0, fg = "#d99368" }, -- peach
          CursorLineNr = { fg = "#d99368" }, -- peach line number

          -- Window separator - subtle divider
          WinSeparator = { fg = "#8a6f5a", bg = colors.base }, -- muted peach/brown

          -- Dashboard header - purple
          SnacksDashboardHeader = { fg = colors.mauve, style = { "bold" } },
        }
      end,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = {
          enabled = true,
        },
      },
    })
  end,
}
