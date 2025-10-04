local opt = vim.opt

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

