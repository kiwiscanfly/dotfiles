return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
      defaults = {
        preview = {
          treesitter = false,
        },
        mappings = {
          i = {
            ["<esc>"] = require('telescope.actions').close,
          },
        },
      },
    })
  end,
}
