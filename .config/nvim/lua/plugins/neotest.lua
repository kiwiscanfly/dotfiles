return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- Language adapters
    "nvim-neotest/neotest-jest",        -- JavaScript/TypeScript Jest
    "marilari88/neotest-vitest",        -- JavaScript/TypeScript Vitest
    "nvim-neotest/neotest-python",      -- Python pytest/unittest
    "olimorris/neotest-phpunit",        -- PHP PHPUnit
  },
  config = function()
    require("neotest").setup({
      adapters = {
        -- JavaScript/TypeScript - Jest
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),

        -- JavaScript/TypeScript - Vitest
        require("neotest-vitest"),

        -- Python
        require("neotest-python")({
          dap = { justMyCode = false },
          args = { "--log-level", "DEBUG" },
          runner = "pytest",
        }),

        -- PHP
        require("neotest-phpunit")({
          phpunit_cmd = function()
            return "vendor/bin/phpunit"
          end,
        }),
      },

      -- Output settings
      output = {
        enabled = true,
        open_on_run = true,
      },

      -- Status icons
      icons = {
        running = "",
        passed = "",
        failed = "",
        skipped = "",
      },
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>tt", function()
      require("neotest").run.run()
    end, { desc = "Test: Run Nearest" })

    vim.keymap.set("n", "<leader>tf", function()
      require("neotest").run.run(vim.fn.expand("%"))
    end, { desc = "Test: Run File" })

    vim.keymap.set("n", "<leader>ta", function()
      require("neotest").run.run(vim.fn.getcwd())
    end, { desc = "Test: Run All" })

    vim.keymap.set("n", "<leader>ts", function()
      require("neotest").summary.toggle()
    end, { desc = "Test: Toggle Summary" })

    vim.keymap.set("n", "<leader>to", function()
      require("neotest").output.open({ enter = true })
    end, { desc = "Test: Show Output" })

    vim.keymap.set("n", "<leader>tO", function()
      require("neotest").output_panel.toggle()
    end, { desc = "Test: Toggle Output Panel" })

    vim.keymap.set("n", "<leader>td", function()
      require("neotest").run.run({ strategy = "dap" })
    end, { desc = "Test: Debug Nearest" })
  end,
}
