return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/Myspace/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/Myspace/*.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "MyObsidian",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Myspace",
      },
    },

    -- see below for full list of options 👇
  },
}
