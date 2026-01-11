-- Add to ~/.config/nvim/lua/plugins/cmake.lua
return {
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      cmake_build_directory = "build",
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_options = {},
      cmake_console_size = 10,
      cmake_show_console = "always",
    },
    keys = {
      { "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "CMake Generate" },
      { "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake Build" },
      { "<leader>cr", "<cmd>CMakeRun<cr>", desc = "CMake Run" },
      { "<leader>cc", "<cmd>CMakeClean<cr>", desc = "CMake Clean" },
      { "<leader>ct", "<cmd>CMakeSelectBuildTarget<cr>", desc = "CMake Select Target" },
    },
  },
}
