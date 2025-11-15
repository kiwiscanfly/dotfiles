return {
  "vimpostor/vim-tpipeline",
  config = function()
    vim.g.tpipeline_autoembed = 1 -- Automatically embed statusline in tmux
    vim.g.tpipeline_statusline = '' -- Use existing statusline (lualine)
  end,
}
