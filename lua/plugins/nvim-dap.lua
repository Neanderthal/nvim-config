function venv_python_path()
  -- This function now correctly builds the path based on the VIRTUAL_ENV environment variable.
  local venv_path = os.getenv("VIRTUAL_ENV")
  if venv_path and file_exists(venv_path .. "/bin/python") then
    return venv_path .. "/bin/python"
  else
    return "/usr/bin/python" -- Default system Python path
  end
end

function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

-- Update the PATH environment variable within Neovim
vim.env.PATH = os.getenv("VIRTUAL_ENV") .. "/bin:" .. vim.env.PATH

return {
  "mfussenegger/nvim-dap",
  resolve_python = function()
    return os.getenv("VIRTUAL_ENV") .. "/bin/python"
  end,
  optional = true,
  adapters = {
    python = {
      type = "executable",
      command = venv_python_path(),
      args = { "-m", "debugpy" },
    },
  },
  configurations = {
    python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = venv_python_path(),
      },
      {
        type = "debugpy",
        request = "launch",
        name = "Django",
        program = "${workspaceFolder}/manage.py",
        args = {
          "runserver",
        },
        justMyCode = true,
        django = true,
        console = "integratedTerminal",
        pythonPath = venv_python_path(),
      },
      {
        type = "python",
        request = "attach",
        name = "Attach remote",
        connect = function()
          return {
            host = "localhost",
            port = 5678,
          }
        end,
      },
      {
        type = "python",
        request = "launch",
        name = "Launch file with arguments",
        program = "${file}",
        args = function()
          local args_string = vim.fn.input("Arguments: ")
          return vim.split(args_string, " +")
        end,
        console = "integratedTerminal",
        pythonPath = venv_python_path(),
      },
    },
  },
  dependencies = {
    "mfussenegger/nvim-dap-python",
    -- stylua: ignore
    keys = {
      { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
      { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
    },
    config = function()
      require("dap-python").setup(os.getenv("VIRTUAL_ENV") .. "/bin/python")
    end,
  },
}
