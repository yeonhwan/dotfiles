return {
  -- lsp config
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          hovers = true,
          suggestions = true,
          root_dir = function(fname)
            local root_pattern =
              require("lspconfig").util.root_pattern("tailwind.config.cjs", "tailwind.config.js", "postcss.config.js")
            return root_pattern(fname)
          end,
        },
      },
    },
  },
  --treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      fold = {
        enable = true,
      },
    },
  },
}
