return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      local lspconfig = require("lspconfig")

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set("n", "<leader>x", vim.diagnostic.open_float, { desc = "Show diagnostic" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",        -- Lua
          "vtsls",         -- TypeScript/JavaScript (faster alternative to ts_ls)
          "pyright",       -- Python (type checking)
          "ruff",          -- Python (linting/formatting) - renamed from ruff_lsp
          "intelephense",  -- PHP
          "html",          -- HTML
          "cssls",         -- CSS
          "jsonls",        -- JSON
        },
        automatic_installation = true,
        handlers = {
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,
        ["pyright"] = function()
          lspconfig.pyright.setup({
            capabilities = capabilities,
            settings = {
              python = {
                analysis = {
                  typeCheckingMode = "basic",
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                },
              },
            },
          })
        end,
        ["ruff"] = function()
          lspconfig.ruff.setup({
            capabilities = capabilities,
            init_options = {
              settings = {
                args = {},
              },
            },
          })
        end,
        ["html"] = function()
          lspconfig.html.setup({
            capabilities = capabilities,
            init_options = {
              configurationSection = { "html", "css", "javascript" },
              embeddedLanguages = {
                css = true,
                javascript = true,
              },
              provideFormatter = true,
            },
          })
        end,
        },
      })
    end
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
  },
  {
    "williamboman/mason-lspconfig.nvim",
  }
}