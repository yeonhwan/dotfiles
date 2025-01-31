return {
  "mfussenegger/nvim-dap",
  optional = true,
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "js-debug-adapter")
      end,
    },
  },

  opts = function()
    local dap = require("dap")

    local chrome_adapter_config = {
      type = "executable",
      command = "node",
      args = {
        LazyVim.get_pkg_path("chrome-debug-adapter", "/out/src/chromeDebug.js"),
      },
    }

    local js_adapters = {
      ["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- 💀 Make sure to update this path to point to your installation
          args = {
            LazyVim.get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
            "${port}",
          },
        },

        ["node"] = function(cb, config)
          if config.type == "node" then
            config.type = "pwa-node"
          end
          local nativeAdapter = dap.adapters["pwa-node"]
          if type(nativeAdapter) == "function" then
            nativeAdapter(cb, config)
          else
            cb(nativeAdapter)
          end
        end,
      },

      ["pwa-chrome"] = chrome_adapter_config,
      ["chrome"] = chrome_adapter_config,
    }

    for name, config in pairs(js_adapters) do
      if not dap.adapters[name] then
        dap.adapters[name] = config
      end
    end

    local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

    local vscode = require("dap.ext.vscode")
    vscode.type_to_filetypes["node"] = js_filetypes
    vscode.type_to_filetypes["pwa-node"] = js_filetypes
    vscode.type_to_filetypes["pwa-chrome"] = js_filetypes
    vscode.type_to_filetypes["chrome"] = js_filetypes

    for _, language in ipairs(js_filetypes) do
      dap.configurations[language] = {
        {
          name = "Launch Node File",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          name = "Attach to process",
          type = "pwa-node",
          request = "attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          name = "Launch Chrome",
          type = "pwa-chrome",
          request = "launch",
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({
                prompt = "Enter URL: ",
                default = "http://localhost:3000",
              }, function(url)
                if url == nil or url == "" then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = vim.fn.getcwd(),
          sourceMaps = true,
        },
      }
    end
  end,
}
