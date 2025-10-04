return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local colors = {
      blue = '#89b4fa',
      cyan = '#89dceb',
      green = '#a6e3a1',
      yellow = '#f9e2af',
      orange = '#fab387',
      red = '#f38ba8',
      pink = '#f5c2e7',
      mauve = '#cba6f7',
      lavender = '#b4befe',
      bg = '#1e1e2e',
    }

    local rainbow_theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.lavender, fg = colors.bg },
        c = { bg = colors.cyan, fg = colors.bg },
        x = { bg = colors.green, fg = colors.bg },
        y = { bg = colors.yellow, fg = colors.bg },
        z = { bg = colors.orange, fg = colors.bg, gui = 'bold' },
      },
      insert = {
        a = { bg = colors.green, fg = colors.bg, gui = 'bold' },
        z = { bg = colors.pink, fg = colors.bg, gui = 'bold' },
      },
      visual = {
        a = { bg = colors.mauve, fg = colors.bg, gui = 'bold' },
        z = { bg = colors.red, fg = colors.bg, gui = 'bold' },
      },
      replace = {
        a = { bg = colors.red, fg = colors.bg, gui = 'bold' },
        z = { bg = colors.mauve, fg = colors.bg, gui = 'bold' },
      },
    }

    require('lualine').setup({
      options = {
        theme = rainbow_theme,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'diagnostics', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
    })
  end,
}
