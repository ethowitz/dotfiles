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
      -- Plugin configuration
      tools = {},
      -- LSP configuration
      server = {
        on_attach = function(client, bufnr)
          -- you can also put keymaps in here
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            serverPath = "/Users/ethan/Dev/rust-analyzer/target/release/rust-analyzer",
            cargo = {
              ignoreCrates = {
                "xtask",
                "edition",
                "stdx",
                "la-arena",
                "line-index",
                "lsp-server",
                "base-db",
                "cfg",
                -- "intern",
                "tt",
                "syntax",
                "parser",
                "limit",
                "test-utils",
                "paths",
                "profile",
                "syntax-bridge",
                "span",
                "salsa",
                "salsa-macros",
                "vfs",
                "hir",
                "hir-def",
                "hir-expand",
                "mbe",
                "test-fixture",
                "hir-ty",
                "project-model",
                "toolchain",
                "ide",
                "ide-assists",
                "ide-db",
                "ide-completion",
                "ide-diagnostics",
                "ide-ssr",
                "load-cargo",
                "proc-macro-api",
                "vfs-notify",
                "proc-macro-srv",
                "proc-macro-test",
                "proc-macro-srv-cli",
                "rust-analyzer",
              },
            },
            check = {
              command = "check",
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
            -- linkedProjects = { '/home/discord/dev/Cargo.toml' },
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
      -- DAP configuration
      dap = {},
    }
  end,
}
