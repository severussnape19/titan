--Treesitter configuration

      require("nvim-treesitter.configs")
          .setup({
              ensure_installed =
                  {
                      "c",
                      "cpp",
                      "rust",
                      "lua",
                  },
              highlight =
                  {
                      enable = true,
                  },
          })
