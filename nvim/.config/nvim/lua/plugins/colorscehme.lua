return {
  -- nightfox
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
          terminal_colors = false,
          styles = {
            comments = "italic",
            keywords = "bold",
            functions = "italic,bold",
            operators = "bold",
            variables = "bold",
          },
        },
        groups = {
          all = {
            NormalFloat = {
              fg = "fg1",
              bg = "NONE",
            },
          },
        },
      })
    end,
  },
  --tokyonight
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "Night",
      transparent = true,
      styles = {
        floats = "transparent",
        sidebars = "transparent",
      },
      on_colors = function(colors)
        colors.bg_dark = "#1f2335"
      end,
    },
  },
  -- solarized-osaka
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        floats = "transparent",
        sidebars = "transparent",
      },
    },
  },
}
