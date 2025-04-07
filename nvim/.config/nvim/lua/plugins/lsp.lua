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
}
