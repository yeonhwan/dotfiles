-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps hereby

function Map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

Map("i", "jj", "<ESC>")

-- Increment / Decrement
Map("n", "+", "<C-a>")
Map("n", "-", "<C-x>")

-- set to nil not to collapse with select all
vim.keymap.set("n", "g<C-a>", "", { noremap = true })
vim.keymap.set("n", "g<C-x>", "", { noremap = true })

-- Jumplist
Map("n", "<C-m>", "<C-i>")

-- Tab
Map("n", "<leader>to", ":tabnew<Return>")
Map("n", "<leader>tx", ":tabclose<Return>")
Map("n", "<leader>tp", ":tabp<Return>")
Map("n", "<leader>tf", ":tabnew %<Return>")
Map("n", "<leader>tn", ":tabn<Return>")

-- Split window controls
Map("n", "<C-w>m", ":vsplit<Return>")
Map("n", "<C-w>n", ":split<Return>")
Map("n", "<C-w>x", "<cmd>close<CR>")
Map("n", "<C-w>e", "<C-w>=")

-- Switching buffers
Map("n", "<C-l>", ":BufferLineCycleNext<CR>")
Map("n", "<C-h>", ":BufferLineCyclePrev<CR>")

-- Remap Jump movements
Map("n", "H", "H")
Map("n", "L", "L")

-- Jump pages
Map("n", "gj", "ztM")
Map("n", "gk", "zbM")

-- Move window
Map("n", "sh", "<C-w>h")
Map("n", "sk", "<C-w>k")
Map("n", "sj", "<C-w>j")
Map("n", "sl", "<C-w>l")

-- Save
Map("n", "<C-s>", ":w<Return>")

-- Remap move between buffers

-- Resize window
Map("n", "<C-w><left>", "<C-w><")
Map("n", "<C-w><right>", "<C-w>>")
Map("n", "<C-w><up>", "<C-w>+")
Map("n", "<C-w><down>", "<C-w>-")

Map("n", "<leader>nh", ":nohlsearch<CR>")

-- Diagnostics
Map("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end)

-- Select all
Map("n", "<C-a>", "gg<S-v>G")

-- select colorscheme
Map("n", "<C-c>:", ":FzfLua colorschemes<CR>")
