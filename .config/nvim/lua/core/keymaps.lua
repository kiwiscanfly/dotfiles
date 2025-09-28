local keymap = vim.keymap.set

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep in files" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

-- Neo-tree
keymap("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })
keymap("n", "<leader>E", "<cmd>Neotree reveal<cr>", { desc = "Reveal current file in explorer" })

-- File change detection autocommands
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "CursorHold"}, {
  pattern = "*",
  command = "checktime",
  desc = "Check for file changes when focusing or entering buffer"
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk and reloaded!", vim.log.levels.WARN)
  end,
  desc = "Alert when file is reloaded due to external changes"
})

vim.api.nvim_create_autocmd("FileChangedShell", {
  pattern = "*",
  callback = function()
    if vim.bo.modified then
      vim.notify("File changed on disk but you have unsaved changes! Use :e to reload or save first.", vim.log.levels.ERROR)
    end
  end,
  desc = "Alert when file changes but buffer is modified"
})
