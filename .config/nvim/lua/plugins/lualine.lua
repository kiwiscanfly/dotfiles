return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'AndreM222/copilot-lualine',
  },
  config = function()
    local colors = {
      -- Base colors
      bg = '#4d3d52',

      -- Rainbow gradient (pastel, soft) with peach accent
      blue = '#7d9dcc',
      sky = '#7db3c4',
      teal = '#85c4b8',
      green = '#99d1a0',
      yellow = '#d9c9a0',
      peach = '#d99368',

      -- Insert gradient (subtle dark purples)
      purple_dark = '#7c6f9f',
      purple_mid = '#8a7ca8',
      purple_light = '#9889b1',

      -- Visual gradient (purples)
      mauve_dark = '#b4a6f7',
      mauve = '#cba6f7',
      pink = '#f5c2e7',

      -- Replace gradient (reds/oranges)
      red = '#f38ba8',
      maroon = '#eba0ac',
      peach_light = '#fcc5a7',
    }

    local rainbow_theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.sky, fg = colors.bg },
        c = { bg = colors.teal, fg = colors.bg },
        x = { bg = colors.green, fg = colors.bg },
        y = { bg = colors.yellow, fg = colors.bg },
        z = { bg = colors.peach, fg = colors.bg, gui = 'bold' },
      },
      insert = {
        a = { bg = colors.purple_dark, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.purple_dark, fg = colors.bg },
        c = { bg = colors.purple_mid, fg = colors.bg },
        x = { bg = colors.purple_mid, fg = colors.bg },
        y = { bg = colors.purple_light, fg = colors.bg },
        z = { bg = colors.purple_light, fg = colors.bg, gui = 'bold' },
      },
      visual = {
        a = { bg = colors.mauve_dark, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.mauve, fg = colors.bg },
        c = { bg = colors.pink, fg = colors.bg },
        x = { bg = colors.pink, fg = colors.bg },
        y = { bg = colors.mauve, fg = colors.bg },
        z = { bg = colors.mauve_dark, fg = colors.bg, gui = 'bold' },
      },
      replace = {
        a = { bg = colors.red, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.maroon, fg = colors.bg },
        c = { bg = colors.peach_light, fg = colors.bg },
        x = { bg = colors.peach_light, fg = colors.bg },
        y = { bg = colors.maroon, fg = colors.bg },
        z = { bg = colors.red, fg = colors.bg, gui = 'bold' },
      },
    }

    require('lualine').setup({
      options = {
        theme = rainbow_theme,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'copilot', 'diagnostics', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
    })
  end,
}
