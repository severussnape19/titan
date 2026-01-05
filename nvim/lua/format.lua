-- =========================
-- Formatting setup
-- =========================

require("conform").setup({
  formatters_by_ft = {
    rust = { "rustfmt" },
    c = { "clang_format" },
    cpp = { "clang_format" },
  },
})

