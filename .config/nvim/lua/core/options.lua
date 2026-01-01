local opt = vim.opt

-- macOS: Add Homebrew to PATH for GUI apps
if vim.fn.has("mac") == 1 then
  vim.env.PATH = "/opt/homebrew/bin:" .. vim.env.PATH
end

-- Line Numbers
opt.relativenumber = true
opt.number = true

-- Tabs and Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Line Wrapping
opt.wrap = false

-- Search Settings
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8

-- Folding (nvim-ufo)
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.fillchars = { vert = "│", vertleft = "│", vertright = "│", verthoriz = "│" }

-- Show whitespace characters
opt.list = true
opt.listchars = {
  tab = "▸ ",
  space = "·",
  trail = "•",
  nbsp = "␣",
  eol = "¬",
}

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split Windows
opt.splitright = true
opt.splitbelow = true

-- Include dash as part of a word
opt.iskeyword:append("-")

-- Enable mouse support
opt.mouse = "a"

-- File change detection
opt.autoread = true -- Automatically reload files when changed externally
opt.updatetime = 250 -- Faster completion and file change detection (default 4000ms)

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 200,
    })
  end,
})
