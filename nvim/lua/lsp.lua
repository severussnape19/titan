-- =========================
-- LSP (Neovim native API)
-- =========================

local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

-- Mason setup
mason.setup()

mason_lsp.setup({
  ensure_installed = {
    "rust_analyzer",
    "clangd",
  },
})

-- Capabilities for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- =========================
-- Rust
-- =========================
vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})

-- =========================
-- C / C++
-- =========================
vim.lsp.config("clangd", {
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
  },
})

-- Enable servers
vim.lsp.enable({ "rust_analyzer", "clangd" })

