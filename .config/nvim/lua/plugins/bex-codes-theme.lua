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
          -- Bex Codes color palette
          base = "#282828",       -- Ghostty background
          surface0 = "#313131",   -- Subtle grey (cursor line)
          surface1 = "#3a3a3a",   -- Slightly lighter grey (borders, selections)
          surface2 = "#3a3a3a",   -- Slightly lighter grey
          overlay0 = "#7c6f9f",   -- Medium purple (comments, line numbers)
          overlay1 = "#9399b2",   -- Keep original
          overlay2 = "#a6adc8",   -- Keep original

          -- Syntax colors mapped to Bex Codes
          red = "#f5a97f",        -- Peach (parameters, builtins, this/self)
          peach = "#d99368",      -- Orange (numbers, constants, decorators)
          yellow = "#d9c9a0",     -- Yellow (types, classes, namespaces)
          green = "#99d1a0",      -- Green (strings)
          teal = "#85c4b8",       -- Aqua (operators, enum values)
          sapphire = "#85c4b8",   -- Aqua (special)
          blue = "#7d9dcc",       -- Blue (functions, tags)
          sky = "#7d9dcc",        -- Blue (special functions)
          lavender = "#7d9dcc",   -- Blue (hints)
          mauve = "#cba6f7",      -- Light purple (keywords) - keep original
        },
      },
      custom_highlights = function(colors)
        return {
          -- Cursor
          Cursor = { bg = colors.peach, fg = colors.base },
          lCursor = { bg = colors.peach, fg = colors.base },
          CursorLine = { bg = colors.surface0 },
          CursorLineNr = { fg = colors.peach }, -- Orange line number

          -- Windows and borders
          WinSeparator = { fg = colors.surface1, bg = colors.base },
          NormalFloat = { bg = colors.base },
          FloatBorder = { bg = colors.base, fg = colors.surface1 },

          -- Popup menu
          Pmenu = { bg = colors.surface0, fg = colors.text },
          PmenuSel = { bg = colors.surface1, fg = colors.peach, bold = true },
          PmenuSbar = { bg = colors.surface0 },
          PmenuThumb = { bg = colors.surface1 },

          -- Tabs
          TabLine = { bg = colors.surface0, fg = colors.overlay0 },
          TabLineSel = { bg = colors.surface1, fg = colors.peach, bold = true },
          TabLineFill = { bg = colors.base },

          -- Telescope
          TelescopeNormal = { bg = colors.base },
          TelescopeBorder = { bg = colors.base, fg = colors.surface1 },
          TelescopeSelection = { bg = colors.surface0, fg = colors.peach },
          TelescopeSelectionCaret = { fg = colors.peach },
          TelescopePromptPrefix = { fg = colors.mauve },

          -- Git signs
          GitSignsAdd = { fg = colors.green },
          GitSignsChange = { fg = colors.yellow },
          GitSignsDelete = { fg = colors.red },

          -- Directory and file selection
          Directory = { fg = colors.blue },

          -- Snacks specific
          SnacksNormal = { bg = colors.base },
          SnacksBorder = { bg = colors.base, fg = colors.surface1 },
          SnacksIndent = { fg = colors.surface1 },
          SnacksIndentScope = { fg = colors.peach },
          SnacksDashboardHeader = { fg = colors.mauve, bold = true },

          -- Line numbers
          LineNr = { fg = colors.overlay2 },

          -- Statusline (for plugins that use it)
          StatusLine = { bg = colors.surface0, fg = colors.text },
          StatusLineNC = { bg = colors.base, fg = colors.overlay0 },

          -- Render-markdown.nvim
          RenderMarkdownCode = { bg = colors.surface0 },
          RenderMarkdownCodeInline = { bg = colors.surface1 },
          RenderMarkdownCodeBorder = { fg = colors.surface1 },
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
