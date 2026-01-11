-- ~/.config/nvim/lua/config/keymaps.lua
-- Enhanced keybindings for efficient development

local map = vim.keymap.set

-- ============================================================================
-- Better defaults
-- ============================================================================
-- Clear search highlighting
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows with arrows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- ============================================================================
-- Buffer management
-- ============================================================================
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>%bd|e#|bd#<CR>", { desc = "Delete all buffers except current" })

-- ============================================================================
-- Tab management
-- ============================================================================
map("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Close other tabs" })

-- ============================================================================
-- Better text editing
-- ============================================================================
-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better paste (don't yank replaced text)
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Join lines without moving cursor
map("n", "J", "mzJ`z", { desc = "Join lines" })

-- Center search results
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- ============================================================================
-- File operations
-- ============================================================================
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Quit all (force)" })

-- ============================================================================
-- Split management
-- ============================================================================
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Horizontal split" })
map("n", "<leader>se", "<C-w>=", { desc = "Equal splits" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

-- ============================================================================
-- Quick fix list
-- ============================================================================
map("n", "<leader>co", "<cmd>copen<CR>", { desc = "Open quickfix" })
map("n", "<leader>cc", "<cmd>cclose<CR>", { desc = "Close quickfix" })
map("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })

-- ============================================================================
-- Location list
-- ============================================================================
map("n", "<leader>lo", "<cmd>lopen<CR>", { desc = "Open location list" })
map("n", "<leader>lc", "<cmd>lclose<CR>", { desc = "Close location list" })
map("n", "[l", "<cmd>lprev<CR>", { desc = "Previous location" })
map("n", "]l", "<cmd>lnext<CR>", { desc = "Next location" })

-- ============================================================================
-- Terminal
-- ============================================================================
map("n", "<leader>tt", "<cmd>terminal<CR>", { desc = "Open terminal" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ============================================================================
-- Neovide specific
-- ============================================================================
if vim.g.neovide then
  -- Paste in insert mode
  map("i", "<C-S-v>", '<C-r>+', { desc = "Paste" })
  map("c", "<C-S-v>", '<C-r>+', { desc = "Paste" })

  -- Copy to system clipboard
  map("v", "<C-S-c>", '"+y', { desc = "Copy to clipboard" })

  -- Font size controls
  map("n", "<C-=>", "<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>", { desc = "Increase font size" })
  map("n", "<C-->", "<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>", { desc = "Decrease font size" })
  map("n", "<C-0>", "<cmd>lua vim.g.neovide_scale_factor = 1.0<CR>", { desc = "Reset font size" })

  -- Fullscreen toggle
  map("n", "<F11>", "<cmd>lua vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen<CR>", { desc = "Toggle fullscreen" })
end

-- ============================================================================
-- Useful toggles
-- ============================================================================
map("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle line wrap" })
map("n", "<leader>ur", "<cmd>set relativenumber!<CR>", { desc = "Toggle relative numbers" })
map("n", "<leader>us", "<cmd>set spell!<CR>", { desc = "Toggle spell check" })
