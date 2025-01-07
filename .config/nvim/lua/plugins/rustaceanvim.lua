return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  lazy = false,
  keys = {
    {
      "<C-j>",
      function()
        vim.cmd.RustLsp("joinLines")
      end,
    },
    {
      "<leader>rd",
      function()
        vim.cmd.RustLsp("openDocs")
      end,
      desc = "open docs",
    },
    {
      "<leader>re",
      function()
        vim.cmd.RustLsp("expandMacro")
      end,
    },
    {
      "<leader>re",
      function()
        vim.cmd.RustLsp("expandMacro")
      end,
      desc = "expand macro",
    },
    {
      "<leader>rx",
      function()
        vim.cmd.RustLsp({ "explain error", "current" })
      end,
      desc = "explain error",
    },
  },
  config = function()
    vim.g.rustaceanvim = {
      tools = {},
      server = {
        on_attach = function(client, bufnr)
          -- you can also put keymaps in here
        end,
        default_settings = {
          ["rust-analyzer"] = {
            check = {
              command = "clippy",
              extraArgs = { "--profile", "rust-analyzer" },
              workspace = false,
            },
            cachePriming = {
              enable = false,
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            workspace = {
              symbol = {
                search = {
                  kind = "only_types",
                  scope = "workspace",
                },
              },
            },
          },
        },
      },
      dap = {},
    }
  end,
}
