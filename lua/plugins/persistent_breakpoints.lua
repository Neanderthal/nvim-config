local plugins = {
  {
    "Weissle/persistent-breakpoints.nvim",
    opts = {
      load_breakpoints_event = { "BufReadPost" },
    },
    config = {
      require("dap-python"),
    },
  },
}
return plugins
