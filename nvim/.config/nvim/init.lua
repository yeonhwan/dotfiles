-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.clipboard = ""

-- neovide setup
if vim.g.neovide then
  -- option key is meta
  vim.g.neovide_input_macos_option_key_is_meta = "both"

  -- transparency
  vim.g.neovide_transparency = 0.8

  -- blurs (mac os only)
  vim.g.neovide_window_blurred = true

  -- remember window size
  vim.g.neovide_remember_window_size = true

  --bg color (deprecated)
  vim.g.neovide_background_color = "#0B3844"
end
