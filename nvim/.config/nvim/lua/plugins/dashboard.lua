return {
  -- snaks.nvim (dashboard config)
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = {
        preset = {
          header = [[ 
                                      |\\__/,|   (`\\ 
                                    _.|o o  |_   ) )
                                  -(((---(((--------"
	 ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ 
	 ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ 
	 ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ 
	 ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ 
	 ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ 
	 ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ 
                                              YEONHWAN    
  ]],
        },
        sections = {
          { section = "header" },
          { section = "startup", padding = 1 },
          { icon = "", section = "keys", title = "Defaults Menu", gap = 0, padding = 1, indent = 2 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        },
      },
    },
  },
}
