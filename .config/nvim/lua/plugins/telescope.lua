return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            -- Use Esc to close in insert mode too
            ["<esc>"] = require('telescope.actions').close,
          },
        },
      },
    })
  end,
}
