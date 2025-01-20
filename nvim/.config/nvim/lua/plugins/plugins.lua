local inputs = require("neo-tree.ui.inputs")
-- Trash the target
local function trash(state)
  local node = state.tree:get_node()
  if node.type == "message" then
    return
  end
  local _, name = require("neo-tree.utils").split_path(node.path)
  local msg = string.format("Are you sure you want to trash '%s'?", name)
  inputs.confirm(msg, function(confirmed)
    if not confirmed then
      return
    end
    vim.api.nvim_command("silent !trash -F " .. node.path)
    require("neo-tree.sources.manager").refresh(state)
  end)
end

-- Trash the selections (visual mode)
local function trash_visual(state, selected_nodes)
  local paths_to_trash = {}
  for _, node in ipairs(selected_nodes) do
    if node.type ~= "message" then
      table.insert(paths_to_trash, node.path)
    end
  end
  local msg = "Are you sure you want to trash " .. #paths_to_trash .. " items?"
  inputs.confirm(msg, function(confirmed)
    if not confirmed then
      return
    end
    for _, path in ipairs(paths_to_trash) do
      vim.api.nvim_command("silent !trash -F " .. path)
    end
    require("neo-tree.sources.manager").refresh(state)
  end)
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["s"] = "noop",
        },
      },
      filtered_items = {
        filesystem = {
          window = {
            mappings = {
              ["O"] = "system_open",
              ["t"] = "trash",
            },
          },
          visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".git",
            ".DS_Store",
            "thumbs.db",
          },
        },
        commands = {
          system_open = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            -- macOs: open file in default application in the background.
            vim.fn.jobstart({ "xdg-open", "-g", path }, { detach = true })
            -- Linux: open file in default application
            vim.fn.jobstart({ "xdg-open", path }, { detach = true })

            -- Windows: Without removing the file from the path, it opens in code.exe instead of explorer.exe
            local p
            local lastSlashIndex = path:match("^.+()\\[^\\]*$") -- Match the last slash and everything before it
            if lastSlashIndex then
              p = path:sub(1, lastSlashIndex - 1) -- Extract substring before the last slash
            else
              p = path -- If no slash found, return original path
            end
            vim.cmd("silent !start explorer " .. p)
          end,
          trash = trash,
          trash_visual = trash_visual,
        },
      },
    },
  },
  --tokyonight
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "Night",
      transparent = true,
      styles = {
        floats = "transparent",
        sidebars = "transparent",
      },
      on_colors = function(colors)
        colors.bg_dark = "#1f2335"
      end,
    },
  },
  -- solarized-osaka
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        floats = "transparent",
        sidebars = "transparent",
      },
    },
  },
  -- Alpha
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    init = false,
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[

██╗   ██╗███████╗ ██████╗ ███╗   ██╗██╗  ██╗██╗    ██╗ █████╗ ███╗   ██╗
╚██╗ ██╔╝██╔════╝██╔═══██╗████╗  ██║██║  ██║██║    ██║██╔══██╗████╗  ██║
 ╚████╔╝ █████╗  ██║   ██║██╔██╗ ██║███████║██║ █╗ ██║███████║██╔██╗ ██║
  ╚██╔╝  ██╔══╝  ██║   ██║██║╚██╗██║██╔══██║██║███╗██║██╔══██║██║╚██╗██║
   ██║   ███████╗╚██████╔╝██║ ╚████║██║  ██║╚███╔███╔╝██║  ██║██║ ╚████║
   ╚═╝   ╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═══╝

                  OPEN YOUR MIND AND GET READY TO TYPE...
      ]]
      dashboard.section.header.val = vim.split(logo, "\n")
    end,
  },
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
  -- cmp / copilot
  -- implementation detail ref: lazyvim/recipes/cmp
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = function(_, opts)
  --     local has_words_before = function()
  --       unpack = unpack or table.unpack
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  --     end
  --
  --     local cmp = require("cmp")
  --
  --     opts.sources = cmp.config.sources({
  --       { name = "buffer", keyword_length = 2 },
  --     })
  --
  --     -- opts.preselect = cmp.PreselectMode.None
  --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --       ["<Tab>"] = cmp.mapping(function(fallback)
  --         -- copilot accept
  --         if require("copilot.suggestion").is_visible() then
  --           require("copilot.suggestion").accept()
  --         elseif cmp.visible() then
  --           -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
  --           cmp.confirm({ select = true })
  --         elseif vim.snippet.active({ direction = 1 }) then
  --           vim.schedule(function()
  --             vim.snippet.jump(1)
  --           end)
  --         elseif has_words_before() then
  --           cmp.complete()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --       ["<CR>"] = cmp.config.disable,
  --     })
  --   end,
  -- },
  --fzf
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end,
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
  -- better TS lsp
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
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
  -- nightfox
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
          terminal_colors = false,
          styles = {
            comments = "italic",
            keywords = "bold",
            functions = "italic,bold",
            operators = "bold",
            variables = "bold",
          },
        },
        groups = {
          all = {
            NormalFloat = {
              fg = "fg1",
              bg = "NONE",
            },
          },
        },
      })
    end,
  },
  -- vim be good
  {
    "ThePrimeagen/vim-be-good",
  },

  -- telescope file browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },

  -- telescope imports
  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("import")
    end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fq", "<cmd>Telescope file_browser<cr>", desc = "File browser" },
      { "<leader>fi", "<cmd>Telescope import<cr>", desc = "Imports" },
    },
  },
}
