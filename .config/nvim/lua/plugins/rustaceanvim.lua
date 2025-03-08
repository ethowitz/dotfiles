local function setup_codelens_refresh(client, bufnr)
  local status_ok, codelens_supported = pcall(function()
    return client.supports_method("textDocument/codeLens")
  end)
  if not status_ok or not codelens_supported then
    return
  end
  local group = "lsp_code_lens_refresh"
  local cl_events = { "BufEnter", "InsertLeave" }
  local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
    group = group,
    buffer = bufnr,
    event = cl_events,
  })

  if ok and #cl_autocmds > 0 then
    return
  end
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_create_autocmd(cl_events, {
    group = group,
    buffer = bufnr,
    callback = function()
      vim.lsp.codelens.refresh({ bufnr = bufnr })
    end,
  })
end

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
          local navic = require("nvim-navic")
          navic.attach(client, bufnr)
          setup_codelens_refresh(client, bufnr)
        end,
        default_settings = {
          ["rust-analyzer"] = {
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
