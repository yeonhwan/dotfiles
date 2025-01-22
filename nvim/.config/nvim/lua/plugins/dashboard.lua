return {
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
}
