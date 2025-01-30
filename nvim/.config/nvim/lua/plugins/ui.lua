return {
  -- blink cmp
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
      },
    },
  },
  -- modes nvim
  {
    "mvllow/modes.nvim",
    config = function()
      require("modes").setup({
        colors = {
          insert = "#2afc80",
          visual = "#e0b4ff",
          delete = "#e94127",
          copy = "#e7f16e",
        },
        line_opacity = 0.35,
      })
    end,
  },
}
