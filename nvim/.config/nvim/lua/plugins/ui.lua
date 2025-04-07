return {
  -- nvim.cmp
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        -- disable CR on completion in cmp
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.abort()
          else
            fallback()
          end
        end),
        -- supertab
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.confirm({ select = true })
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  -- modes nvim
  {
    "mvllow/modes.nvim",
    config = function()
      require("modes").setup({
        colors = {
          insert = "#2afc80",
          visual = "#e0b4ff",
          delete = "#e94127",
          copy = "#e7f16e",
        },
        line_opacity = 0.35,
      })
    end,
  },
  -- whichkey
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "g<C-a>", hidden = true },
        { "g<C-x>", hidden = true },
      },
    },
  },
  -- noice
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
}
