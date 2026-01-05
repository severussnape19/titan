-- =========================
-- DAP setup (safe)
-- =========================

local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  return
end

local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then
  return
end

dapui.setup()

-- =========================
-- Auto open / close UI
-- =========================
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- =========================
-- Adapter: codelldb (SAFE)
-- =========================
local mr_ok, mason_registry = pcall(require, "mason-registry")
if mr_ok and mason_registry.has_package("codelldb") then
  local codelldb = mason_registry.get_package("codelldb")
  local codelldb_path = codelldb:get_install_path()
  local adapter_path = codelldb_path .. "/extension/adapter/codelldb"

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = adapter_path,
      args = { "--port", "${port}" },
    },
  }

  dap.configurations.rust = {
    {
      name = "Debug Rust",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input(
          "Path to executable: ",
          vim.fn.getcwd() .. "/target/debug/",
          "file"
        )
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }

  dap.configurations.c = {
    {
      name = "Debug C",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input(
          "Path to executable: ",
          vim.fn.getcwd() .. "/",
          "file"
        )
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
end

-- =========================
-- Keymaps
-- =========================
vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>B", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)

vim.keymap.set("n", "<leader>dr", function()
  dap.repl.open()
end)

vim.keymap.set("n", "<leader>du", dapui.toggle)
vim.keymap.set("n", "<leader>dc", dap.run_to_cursor)
vim.keymap.set("n", "<leader>dq", dap.terminate)
vim.keymap.set("n", "<leader>dl", dap.run_last)

