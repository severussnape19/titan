require("tokyonight").setup({
  style = "night",        -- night | storm | moon | day
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = false },
    functions = {},
    variables = {},
  },
})

vim.cmd.colorscheme("tokyonight")

