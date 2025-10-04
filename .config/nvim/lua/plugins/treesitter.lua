return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup({
      ensure_installed = {
        -- Programming languages
        "javascript",
        "typescript",
        "tsx",
        "dart",
        "python",
        "rust",
        "go",
        "bash",

        -- Markup and styling
        "html",
        "css",
        "scss",
        "markdown",
        "markdown_inline",

        -- Configuration
        "lua",
        "json",
        "yaml",
        "toml",
        "vim",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
    })
  end,
}
