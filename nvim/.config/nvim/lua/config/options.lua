-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_picker = "fzf"

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.cmd([[
  hi SpellBad   guisp=red    gui=undercurl term=underline cterm=undercurl
  hi SpellCap   guisp=yellow gui=undercurl term=underline cterm=undercurl
  hi SpellRare  guisp=blue   gui=undercurl term=underline cterm=undercurl
  hi SpellLocal guisp=orange gui=undercurl term=underline cterm=undercurl
]])
-- Enable spell checking
-- vim.o.spell = true
