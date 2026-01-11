-- ~/.config/nvim/init.lua
-- Enhanced Neovim configuration for Neovide

-- 1. Set leader keys BEFORE loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 2. Bootstrap Lazy.nvim plugin manager
require("config.lazy")

-- 3. Load editor options and settings
require("config.options")

-- 4. Load keybindings (if file exists)
local ok, _ = pcall(require, "config.keymaps")
if not ok then
  vim.notify("config.keymaps not found - create ~/.config/nvim/lua/config/keymaps.lua", vim.log.levels.WARN)
end

-- 5. Load autocommands
local ok2, _ = pcall(require, "config.autocmds")
if not ok2 then
  vim.notify("config.autocmds not found - create ~/.config/nvim/lua/config/autocmds.lua", vim.log.levels.WARN)
end

-- 6. Load cursor configuration
require("config.cursor")
