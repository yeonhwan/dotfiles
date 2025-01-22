return {
  -- toggleterm
  {
    "akinsho/nvim-toggleterm.lua",
    event = "VimEnter",
    opts = {
      size = 20,
      open_mapping = [[<C-.>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = "3",
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "single",
        winblend = 3,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
  },
}
