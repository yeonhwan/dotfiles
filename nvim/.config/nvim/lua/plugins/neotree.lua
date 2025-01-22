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
}
