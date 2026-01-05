--------------------------------------------------
-- LEADER
--------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------------------------
-- CORE EDITOR FEEL (STABLE & NATURAL)
--------------------------------------------------
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Indentation (tab / backspace / enter feel correct)
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true
opt.autoindent = true
opt.backspace = { "indent", "eol", "start" }

opt.splitright = true
opt.splitbelow = true
opt.showmode = false
opt.updatetime = 200
opt.completeopt = { "menu", "menuone", "noselect" }

--------------------------------------------------
-- GUI (NEOVIDE)
--------------------------------------------------
vim.opt.guifont = "JetBrainsMono Nerd Font:h14"
vim.opt.linespace = 2

--------------------------------------------------
-- BOOTSTRAP lazy.nvim
--------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------
-- PLUGINS
--------------------------------------------------
require("lazy").setup({

--------------------------------------------------
-- COLORSCHEME (APPLE / XCODE-LIKE SEMANTIC HIERARCHY)
--------------------------------------------------
{
  "EdenEast/nightfox.nvim",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("carbonfox")
    local hl = vim.api.nvim_set_hl

    -- Control flow (structure)
    hl(0,"@keyword.return",{fg="#FFFFFF",bold=true})
    hl(0,"@conditional",{fg="#FFFFFF",bold=true})
    hl(0,"@repeat",{fg="#FFFFFF",bold=true})
    hl(0,"@exception",{fg="#FFFFFF",bold=true})
    hl(0,"Keyword",{fg="#FFFFFF",bold=true})

    -- Functions
    hl(0,"@function",{fg="#EAF1FF",bold=true})
    hl(0,"@method",{fg="#EAF1FF",bold=true})

    -- Types
    hl(0,"@type",{fg="#B6C2D0"})
    hl(0,"@storageclass",{fg="#B6C2D0"})
    hl(0,"@type.qualifier",{fg="#C6CEDA"})

    -- Data
    hl(0,"@constant",{fg="#9FC9A3"})
    hl(0,"@string",{fg="#9FC9A3"})
    hl(0,"@number",{fg="#A7DADC"})

    -- Preprocessor
    hl(0,"@include",{fg="#D4D4D4"})
    hl(0,"@define",{fg="#D4D4D4"})
    hl(0,"@preproc",{fg="#D4D4D4"})

    -- Comments
    hl(0,"@comment",{fg="#7C7C7C",italic=true})

    -- UI
    hl(0,"CursorLine",{bg="#141414"})
    hl(0,"LineNr",{fg="#3C3C3C"})
    hl(0,"CursorLineNr",{fg="#FFFFFF",bold=true})
    hl(0,"Visual",{bg="#1E1E1E"})
  end
},

--------------------------------------------------
-- TREESITTER
--------------------------------------------------
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "c","cpp","cuda","rust","lua","bash","vim","vimdoc"
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
},

--------------------------------------------------
-- LSP (MODERN NVIM)
--------------------------------------------------
{
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable("clangd")
    vim.lsp.enable("rust_analyzer")
  end
},

--------------------------------------------------
-- AUTOCOMPLETE
--------------------------------------------------
{
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "L3MON4D3/LuaSnip",
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
      },
    })
  end
},

--------------------------------------------------
-- FILE TREE
--------------------------------------------------
{
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      view = { width = 30 },
      renderer = { highlight_git = true },
    })
  end
},

--------------------------------------------------
-- TELESCOPE
--------------------------------------------------
{
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
},

--------------------------------------------------
-- STATUSLINE
--------------------------------------------------
{
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        section_separators = "",
        component_separators = "",
        icons_enabled = false,
      },
    })
  end
},

--------------------------------------------------
-- INDENT GUIDES
--------------------------------------------------
{
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = { char = "│" },
    scope = { enabled = true },
  },
},

--------------------------------------------------
-- WHICH-KEY
--------------------------------------------------
{ "folke/which-key.nvim", config = true },

--------------------------------------------------
-- SMOOTH CURSOR
--------------------------------------------------
{
  "gen740/SmoothCursor.nvim",
  event = "VeryLazy",
  config = function()
    require("smoothcursor").setup({
      type = "exp",
      speed = 45,
      intervals = 20,
      jump_threshold = 2,
    })
  end
},

--------------------------------------------------
-- GIT
--------------------------------------------------
{ "tpope/vim-fugitive" },

})

--------------------------------------------------
-- KEYBINDINGS (SINGLE SOURCE OF TRUTH)
--------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Quality of life
map("n","<Esc>","<cmd>nohlsearch<CR>",opts)

-- Window navigation
map("n","<C-h>","<C-w>h",opts)
map("n","<C-j>","<C-w>j",opts)
map("n","<C-k>","<C-w>k",opts)
map("n","<C-l>","<C-w>l",opts)

-- Resize splits
map("n","<C-Up>","<cmd>resize +2<CR>",opts)
map("n","<C-Down>","<cmd>resize -2<CR>",opts)
map("n","<C-Left>","<cmd>vertical resize -2<CR>",opts)
map("n","<C-Right>","<cmd>vertical resize +2<CR>",opts)

-- Leader: Files
map("n","<leader>ff","<cmd>Telescope find_files<CR>",opts)
map("n","<leader>fr","<cmd>Telescope oldfiles<CR>",opts)
map("n","<leader>fs","<cmd>w<CR>",opts)
map("n","<leader>fe","<cmd>NvimTreeToggle<CR>",opts)

-- Leader: Buffers
map("n","<leader>bb","<cmd>Telescope buffers<CR>",opts)
map("n","<leader>bn","<cmd>bnext<CR>",opts)
map("n","<leader>bp","<cmd>bprevious<CR>",opts)
map("n","<leader>bd","<cmd>bdelete<CR>",opts)

-- Leader: Search
map("n","<leader>ss","<cmd>Telescope live_grep<CR>",opts)
map("n","<leader>sw","<cmd>Telescope grep_string<CR>",opts)

-- Leader: Code / LSP
map("n","gd",vim.lsp.buf.definition,opts)
map("n","gr",vim.lsp.buf.references,opts)
map("n","K",vim.lsp.buf.hover,opts)
map("n","<leader>ca",vim.lsp.buf.code_action,opts)
map("n","<leader>cn",vim.lsp.buf.rename,opts)
map("n","<leader>ce",vim.diagnostic.open_float,opts)

-- Diagnostics
map("n","[d",vim.diagnostic.goto_prev,opts)
map("n","]d",vim.diagnostic.goto_next,opts)

-- Leader: Git
map("n","<leader>gs","<cmd>Git<CR>",opts)
map("n","<leader>gb","<cmd>Git blame<CR>",opts)

-- Insert mode comfort
map("i","jk","<Esc>",opts)
map("i","kj","<Esc>",opts)

--------------------------------------------------
-- NEOVIDE PHYSICS (FINAL)
--------------------------------------------------
vim.g.neovide_refresh_rate = 120
vim.g.neovide_refresh_rate_idle = 30
vim.g.neovide_no_idle = true

vim.opt.smoothscroll = true
vim.g.neovide_scroll_animation_length = 0.35

vim.g.neovide_cursor_animation_length = 0.18
vim.g.neovide_cursor_trail_size = 0.9
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_vfx_particle_density = 14

vim.g.neovide_transparency = 0.94
