local ruff = "ruff_lsp"
local lsp = "pyright"
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {
        enabled = lsp == "pyright",
        setup = {
          settings = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              extraPaths = { "./src", "./lib" },
            },
          },
        },
      },
      basedpyright = {
        enabled = lsp == "basedpyright",
      },
      [lsp] = {
        enabled = true,
      },
      ruff_lsp = {
        enabled = ruff == "ruff_lsp",
      },
      ruff = {
        enabled = ruff == "ruff",
      },
      [ruff] = {
        keys = {
          {
            "<leader>co",
            function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.organizeImports" },
                  diagnostics = {},
                },
              })
            end,
            desc = "Organize Imports",
          },
        },
      },
    },
    setup = {
      [ruff] = function()
        LazyVim.lsp.on_attach(function(client, _)
          if client.name == ruff then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end)
      end,
    },
  },
}
