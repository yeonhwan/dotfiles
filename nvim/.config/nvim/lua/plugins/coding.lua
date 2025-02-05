return {
  -- aerial
  {
    "stevearc/aerial.nvim",
    opts = {
      attach_mode = "window",
      layout = {
        preserve_equality = true,
        min_width = 30,
      },
    },
  },
  -- dial
  {
    "monaqa/dial.nvim",
    keys = {
      -- overriding default dial keymaps to <C-i>
      {
        "<C-a>",
        nil,
        mode = { "n", "v" },
      },
      {
        "<C-i>",
        function()
          return require("dial.map").inc_normal()
        end,
        expr = true,
        desc = "Dial increment",
        mode = "n",
      },
      {
        "<C-i>",
        function()
          return require("dial.map").inc_visual()
        end,
        expr = true,
        desc = "Dial increment (visual)",
        mode = "v",
      },
      {
        "g<C-i>",
        function()
          return require("dial.map").inc_gnormal()
        end,
        expr = true,
        desc = "Dial group increment",
        mode = "n",
      },
      {
        "g<C-i>",
        function()
          return require("dial.map").inc_gvisual()
        end,
        expr = true,
        desc = "Dial group increment (visual)",
        mode = "v",
      },
    },
  },
  -- blink
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      snippets = {
        preset = "luasnip",
      },
    },
  },
}
