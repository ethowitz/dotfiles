return {
  "folke/trouble.nvim",
  opts = {
    auto_close = true,
    warn_no_results = false,
    open_no_results = true,
    icons = {
      indent = {
        middle = "",
        last = "",
        top = "",
        ws = " ",
      },
    },
    modes = {
      diagnostics = {
        win = {
          size = {
            height = 8,
          },
        },
        multiline = false,
        follow = true,
        format = "{severity_icon} {filename} {message:md} {item.source} {code} {pos}",
        groups = {},
        filter = {
          { severity = { vim.diagnostic.severity.WARN, vim.diagnostic.severity.ERROR } },
        },
      },
      errors = {
        mode = "diagnostics",
        filter = {
          { severity = vim.diagnostic.severity.ERROR },
        },
      },
      warnings = {
        mode = "diagnostics",
        filter = {
          { severity = vim.diagnostic.severity.WARN },
        },
      },
    },
  },
  lazy = false,
  keys = {
    {
      "<leader>x",
      function()
        local trouble = require("trouble")

        trouble.close({ mode = "warnings" })
        trouble.close({ mode = "errors" })
      end,
      silent = true,
    },
    {
      "<leader>e",
      function()
        local trouble = require("trouble")

        if trouble.is_open({ mode = "warnings" }) then
          trouble.close({ mode = "warnings" })
        end

        trouble.toggle({ mode = "errors" })
      end,
      silent = true,
    },
    {
      "<leader>w",
      function()
        local trouble = require("trouble")

        if trouble.is_open({ mode = "errors" }) then
          trouble.close({ mode = "errors" })
        end

        trouble.toggle({ mode = "warnings" })
      end,
      silent = true,
    },
    {
      "[e",
      function()
        local trouble = require("trouble")
        if trouble.is_open({ mode = "warnings" }) then
          trouble.close({ mode = "warnings" })
        end

        trouble.prev({ mode = "errors" })
        trouble.jump({ mode = "errors" })
      end,
      silent = true,
    },
    {
      "]e",
      function()
        local trouble = require("trouble")
        if trouble.is_open({ mode = "warnings" }) then
          trouble.close({ mode = "warnings" })
        end

        trouble.next({ mode = "errors" })
        trouble.jump({ mode = "errors" })
      end,
      silent = true,
    },
    {
      "[w",
      function()
        local trouble = require("trouble")
        if trouble.is_open({ mode = "errors" }) then
          trouble.close({ mode = "errors" })
        end

        trouble.prev({ mode = "warnings" })
        trouble.jump({ mode = "warnings" })
      end,
      silent = true,
    },
    {
      "]w",
      function()
        local trouble = require("trouble")
        if trouble.is_open({ mode = "errors" }) then
          trouble.close({ mode = "errors" })
        end

        trouble.next({ mode = "warnings" })
        trouble.jump({ mode = "warnings" })
      end,
      silent = true,
    },
  },
}
