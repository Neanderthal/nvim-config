local virtual_env = os.getenv("VIRTUAL_ENV")
local python_path = virtual_env and virtual_env .. "/bin/python" or "/usr/bin/python"

return {
  "nvim-neotest/neotest",
  lazy = "true",
  dependencies = {
    "nvim-neotest/neotest-python",
    "plenary",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
      ["neotest-python"] = {
        -- Here you can specify the settings for the adapter, i.e.
        runner = "pytest",
        args = { "--log-level", "DEBUG" },
        pytest_discover_instances = true,
        dap = {
          justMyCode = false,
          django = true,
          jinja = true,
        },
        python = python_path,
      },
    },
  },
}
