return {
  -- blink cmp
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          snippets = {
            min_keyword_length = 2,
            score_offset = 4,
          },
        },
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
  -- whichkey
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "g<C-a>", hidden = true },
        { "g<C-x>", hidden = true },
      },
    },
  },
}
