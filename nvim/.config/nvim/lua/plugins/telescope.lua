return {
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
    keys = {
      { "<leader>fq", "<cmd>Telescope file_browser<cr>", desc = "File browser" },
      { "<leader>fi", "<cmd>Telescope import<cr>", desc = "Imports" },
    },
  },

  -- telescope file browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    enabled = false,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  -- telescope imports
  {
    "piersolenski/telescope-import.nvim",
    enabled = false,
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("import")
    end,
  },
}
