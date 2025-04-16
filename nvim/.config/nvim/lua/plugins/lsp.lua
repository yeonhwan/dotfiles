return {
  --treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      fold = {
        enable = true,
      },
    },
  },
  --lsp config
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
    },
  },
  -- luasnip
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip").filetype_extend("typescript", { "javascript" })
      require("luasnip").filetype_extend("typescriptreact", { "javascript" })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
