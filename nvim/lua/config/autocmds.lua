-- ~/.config/nvim/lua/config/autocmds.lua
-- Auto commands for better workflow
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General settings group
local general = augroup("General", { clear = true })

-- Highlight on yank
autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Auto-save on focus lost
autocmd("FocusLost", {
  group = general,
  callback = function()
    vim.cmd("silent! wa")
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = general,
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Resize splits on window resize
autocmd("VimResized", {
  group = general,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Close certain filetypes with 'q'
autocmd("FileType", {
  group = general,
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Auto create missing directories on save
autocmd("BufWritePre", {
  group = general,
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Return to last edit position when opening files
autocmd("BufReadPost", {
  group = general,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Language-specific settings
local lang = augroup("LanguageSettings", { clear = true })

-- C/C++ settings
autocmd("FileType", {
  group = lang,
  pattern = { "c", "cpp", "h", "hpp" },
  callback = function()
    vim.opt_local.commentstring = "// %s"
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Rust settings
autocmd("FileType", {
  group = lang,
  pattern = "rust",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.colorcolumn = "100"
  end,
})

-- Markdown settings
autocmd("FileType", {
  group = lang,
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 2
  end,
})

-- Git commit messages
autocmd("FileType", {
  group = lang,
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.colorcolumn = "72"
  end,
})

-- Terminal settings
local term = augroup("Terminal", { clear = true })

autocmd("TermOpen", {
  group = term,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- LSP settings
local lsp = augroup("LspSettings", { clear = true })

-- Show diagnostics on cursor hold
autocmd("CursorHold", {
  group = lsp,
  callback = function()
    -- Check if LSP clients are attached to the current buffer
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients > 0 then
      vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
    end
  end,
})

-- Format on save for specific filetypes
autocmd("BufWritePre", {
  group = lsp,
  pattern = { "*.rs", "*.lua" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

autocmd("FileType", {
      group = lang,
        pattern = "cmake",
          callback = function()
                  vim.opt_local.tabstop = 2
                      vim.opt_local.shiftwidth = 2
                          vim.opt_local.softtabstop = 2
                              vim.opt_local.expandtab = true
                                end,
                            })
