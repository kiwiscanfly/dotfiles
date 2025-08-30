return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup({
      ensure_installed = {
        "lua",
        "javascript",
        "markdown",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
    })
  end,
}
