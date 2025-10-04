return {
  'echasnovski/mini.diff',
  version = false,
  config = function()
    require('mini.diff').setup({
      view = {
        style = 'sign', -- Show in sign column, not number column
        signs = { add = '▎', change = '▎', delete = '▁' },
      },
      mappings = {
        apply = 'gh',
        reset = 'gH',
        textobject = 'gh',
        goto_first = '[H',
        goto_prev = '[h',
        goto_next = ']h',
        goto_last = ']H',
      },
    })
    -- Ensure line numbers stay enabled
    vim.opt.number = true
    vim.opt.signcolumn = 'yes' -- Keep sign column always visible
  end,
}
