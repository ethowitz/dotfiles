local function tablelength(table)
  local count = 0
  for _ in pairs(table) do
    count = count + 1
  end
  return count
end

local function setup_keybindings(bufnr)
  require("which-key").add({
    {
      "<leader>rd",
      function()
        vim.cmd.RustLsp("openDocs")
      end,
      desc = "Open docs",
    },
    {
      "<leader>re",
      function()
        vim.cmd.RustLsp("expandMacro")
      end,
    },
    {
      "<leader>rr",
      function()
        vim.cmd.RustLsp("relatedDiagnostics")
      end,
      desc = "Related diagnostics",
    },
    {
      "<leader>rp",
      function()
        vim.cmd.RustLsp("rebuildProcMacros")
      end,
      desc = "Rebuild proc macros",
    },
    {
      "<leader>rx",
      function()
        vim.cmd.RustLsp({ "explainError", "current" })
      end,
      desc = "Explain error",
    },
    {
      "<space>e",
      function()
        vim.cmd.RustLsp({ "renderDiagnostic", "current" })
      end,
      desc = "Open LSP diagnostic float",
    },
    {
      "<leader>x",
      function()
        vim.cmd.RustLsp("flyCheck")
      end,
      desc = "Fun flycheck",
    },
    {
      "K",
      function()
        vim.cmd.RustLsp({ "hover", "actions" })
      end,
    },
  }, {
    buffer = bufnr,
    silent = true,
  })
end

return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      tools = {},
      server = {
        on_attach = function(client, bufnr)
          local navic = require("nvim-navic")
          navic.attach(client, bufnr)

          setup_keybindings()

          vim.cmd.RustLsp("flyCheck")
        end,
        default_settings = {
          -- TODO: add config options to control behavior across different machines (e.g. vim.g.enable_cargo_filtered)
          ["rust-analyzer"] = {
            checkOnSave = false,
            -- cmd = { "/Users/ethan/.local/bin/rust-analyzer" },
            check = {
              command = "clippy",
              extraArgs = { "--profile", "rust-analyzer" },
              -- extraEnv = {
              --   ["CARGO"] = "/Users/ethan/.cargo/bin/cargo-filtered",
              -- },
            },
          },
        },
      },
      dap = {},
    }
  end,
}
