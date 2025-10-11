return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      -- Install essential parsers for Neovim and commonly used languages
      ensure_installed = {
        'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline',
        'typescript', 'tsx', 'javascript',
      },

      -- Install parsers asynchronously
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      -- Syntax highlighting
      highlight = {
        enable = true,

        -- Disable for large files (performance)
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,

        -- Don't use additional vim regex highlighting
        additional_vim_regex_highlighting = false,
      },

      -- Indentation based on treesitter
      indent = {
        enable = true,
      },

      -- Incremental selection based on treesitter
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          node_incremental = '<CR>',
          scope_incremental = '<S-CR>',
          node_decremental = '<BS>',
        },
      },
    })
  end,
}
