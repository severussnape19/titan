-- Tree-sitter configuration for systems and graphics programming
-- Optimized for C++, C, and Rust development

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },

  config = function()
    -- Use the correct API for modern nvim-treesitter
    require("nvim-treesitter").setup({
      -- Install parsers for systems and graphics programming
      ensure_installed = {
        "c",
        "cpp",
        "rust",
        "cmake",
        "make",
        "glsl",
        "toml",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "vim",
        "lua",
        "bash",
        "python",
      },

      sync_install = false,
      auto_install = true,

      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<S-CR>",
          node_decremental = "<BS>",
        },
      },
    })

    -- Folding with Tree-sitter
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt.foldenable = false
    vim.opt.foldlevel = 99

    -- Highlight groups for better C++/Rust semantics
    vim.api.nvim_set_hl(0, "@type.qualifier", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "@storageclass", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "@namespace", { link = "Include" })
    vim.api.nvim_set_hl(0, "@variable.builtin", { link = "Special" })
  end,
}

