-- ~/.config/nvim/lua/config/options.lua
-- Enhanced editor options for Neovide and development

local opt = vim.opt
local g = vim.g

-- ============================================================================
-- Disable unused providers
-- ============================================================================
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python3_provider = 0
g.loaded_node_provider = 0

-- ============================================================================
-- UI & Appearance
-- ============================================================================
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.colorcolumn = "100"
opt.showmode = false
opt.cmdheight = 1
opt.pumheight = 10
opt.scrolloff = 8
opt.sidescrolloff = 8

-- ============================================================================
-- Neovide-specific settings
-- ============================================================================
if g.neovide then
  -- Font
  opt.guifont = "JetBrainsMono Nerd Font:h13:#e-subpixelantialias"

  -- Refresh rate
  g.neovide_refresh_rate = 60
  g.neovide_refresh_rate_idle = 5

  -- Animations (enhanced but subtle)
  g.neovide_cursor_animation_length = 0.13
  g.neovide_cursor_trail_size = 0.8
  g.neovide_cursor_antialiasing = true
  g.neovide_cursor_animate_in_insert_mode = true
  g.neovide_cursor_animate_command_line = true
  g.neovide_cursor_unfocused_outline_width = 0.125

  -- No particle effects
  g.neovide_cursor_vfx_mode = ""

  -- Transparency (using new API)
  g.neovide_window_blurred = true
  vim.o.winblend = 0
  vim.o.pumblend = 0

  -- Background opacity
  if vim.g.neovide then
    vim.cmd([[highlight Normal guibg=#1e1e2e]])
    vim.cmd([[highlight NormalFloat guibg=#1e1e2e]])
  end

  -- Padding
  g.neovide_padding_top = 0
  g.neovide_padding_bottom = 0
  g.neovide_padding_right = 0
  g.neovide_padding_left = 0

  -- Performance
  g.neovide_remember_window_size = true
  g.neovide_profiler = false
end

-- ============================================================================
-- Editing
-- ============================================================================
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.breakindent = true
opt.wrap = false
opt.linebreak = true

-- ============================================================================
-- Search
-- ============================================================================
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- ============================================================================
-- Splits
-- ============================================================================
opt.splitright = true
opt.splitbelow = true

-- ============================================================================
-- Performance
-- ============================================================================
opt.updatetime = 250
opt.timeoutlen = 300
opt.lazyredraw = false -- Keep false for Neovide smoothness
opt.synmaxcol = 300 -- Don't syntax highlight super long lines

-- ============================================================================
-- Backup & Swap
-- ============================================================================
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- ============================================================================
-- Completion
-- ============================================================================
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("c")

-- ============================================================================
-- Clipboard
-- ============================================================================
opt.clipboard = "unnamedplus"

-- ============================================================================
-- Mouse
-- ============================================================================
opt.mouse = "a"
opt.mousemoveevent = true

-- ============================================================================
-- Filetype specific settings
-- ============================================================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp", "c", "h", "hpp" },
  callback = function()
    opt.commentstring = "// %s"
    opt.tabstop = 2
    opt.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    opt.tabstop = 4
    opt.shiftwidth = 4
  end,
})

-- ============================================================================
-- Highlight on yank
-- ============================================================================
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- ============================================================================
-- Auto-save on focus lost
-- ============================================================================
vim.api.nvim_create_autocmd("FocusLost", {
  callback = function()
    vim.cmd("silent! wa")
  end,
})

-- ============================================================================
-- Remove trailing whitespace on save
-- ============================================================================
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})
