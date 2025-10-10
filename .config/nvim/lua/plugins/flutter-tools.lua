return {
  "nvim-flutter/flutter-tools.nvim",
  ft = "dart",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- Optional: Better UI for selects
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("flutter-tools").setup({
      -- Enable FVM support
      fvm = true,

      -- UI configuration
      ui = {
        border = "rounded",
        notification_style = "plugin", -- Use nvim-notify style
      },

      -- Decorations (closing labels for widgets)
      decorations = {
        statusline = {
          app_version = true,
          device = true,
          project_config = true,
        },
      },

      -- Widget guides
      widget_guides = {
        enabled = true,
      },

      -- Closing labels
      closing_tags = {
        highlight = "Comment",
        prefix = " // ",
        enabled = true,
      },

      -- Development log settings
      dev_log = {
        enabled = true,
        notify_errors = false,
        open_cmd = "tabedit",
      },

      -- LSP configuration
      lsp = {
        color = {
          enabled = true,
          background = false,
          background_color = nil,
          foreground = false,
          virtual_text = true,
          virtual_text_str = "■",
        },
        capabilities = capabilities,
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = {
            vim.fn.expand("$HOME/.pub-cache"),
            vim.fn.expand("$HOME/fvm"),
          },
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
          updateImportsOnRename = true,
          lineLength = 120,
        },
      },

      -- Debugger integration (works with nvim-dap)
      debugger = {
        enabled = true,
        run_via_dap = true,
        register_configurations = function(paths)
          require("dap").configurations.dart = {
            {
              type = "dart",
              request = "launch",
              name = "Launch Flutter Program",
              program = "${workspaceFolder}/lib/main.dart",
              cwd = "${workspaceFolder}",
            },
            {
              type = "flutter",
              request = "launch",
              name = "Launch Flutter App",
              program = "${workspaceFolder}/lib/main.dart",
              cwd = "${workspaceFolder}",
            },
          }
        end,
      },
    })

    -- Keybindings
    local opts = { noremap = true, silent = true }

    -- Flutter commands
    vim.keymap.set("n", "<leader>fr", "<cmd>FlutterReload<cr>", vim.tbl_extend("force", opts, { desc = "Flutter: Hot Reload" }))
    vim.keymap.set("n", "<leader>fR", "<cmd>FlutterRestart<cr>", vim.tbl_extend("force", opts, { desc = "Flutter: Hot Restart" }))
    vim.keymap.set("n", "<leader>fq", "<cmd>FlutterQuit<cr>", vim.tbl_extend("force", opts, { desc = "Flutter: Quit" }))
    vim.keymap.set("n", "<leader>fd", "<cmd>FlutterDevices<cr>", vim.tbl_extend("force", opts, { desc = "Flutter: Select Device" }))
    vim.keymap.set("n", "<leader>fe", "<cmd>FlutterEmulators<cr>", vim.tbl_extend("force", opts, { desc = "Flutter: Emulators" }))
    vim.keymap.set("n", "<leader>fo", "<cmd>FlutterOutlineToggle<cr>", vim.tbl_extend("force", opts, { desc = "Flutter: Toggle Outline" }))
    vim.keymap.set("n", "<leader>fc", "<cmd>FlutterLogClear<cr>", vim.tbl_extend("force", opts, { desc = "Flutter: Clear Log" }))
    vim.keymap.set("n", "<leader>fv", "<cmd>Telescope flutter fvm<cr>", vim.tbl_extend("force", opts, { desc = "Flutter: Switch FVM Version" }))
    vim.keymap.set("n", "<leader>fs", "<cmd>FlutterRun<cr>", vim.tbl_extend("force", opts, { desc = "Flutter: Run" }))
    vim.keymap.set("n", "<leader>fD", "<cmd>FlutterDetach<cr>", vim.tbl_extend("force", opts, { desc = "Flutter: Detach" }))
    vim.keymap.set("n", "<leader>fl", "<cmd>FlutterLspRestart<cr>", vim.tbl_extend("force", opts, { desc = "Flutter: Restart LSP" }))
  end,
}
