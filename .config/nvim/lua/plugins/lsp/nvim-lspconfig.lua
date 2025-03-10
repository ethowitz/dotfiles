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
  -- LSP configuration
  "neovim/nvim-lspconfig",
  lazy = false,
  keys = {
    {
      "<leader>lq",
      function()
        vim.diagnostic.setqflist({ severity = { min = vim.diagnostic.severity.WARN } })
      end,
      desc = "dump LSP diagnostics to quickfix list",
    },
    { "<leader>lR", ":LspRestart<CR>", desc = "restart LSP" },
    { "<leader>ls", ":LspStop<CR>", desc = "stop LSP" },
    { "<leader>lg", ":LspStart<CR>", desc = "start LSP" },
    {
      "<leader>lr",
      function()
        vim.lsp.buf.rename()
      end,
      desc = "rename symbol under cursor",
    },
  },
  config = function()
    local sign = function(opts)
      vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = "",
      })
    end

    sign({ name = "DiagnosticSignError", text = " " })
    sign({ name = "DiagnosticSignWarn", text = " " })
    sign({ name = "DiagnosticSignHint", text = "󰌵 " })
    sign({ name = "DiagnosticSignInfo", text = "󰋼 " })

    vim.diagnostic.config({
      on_init_callback = function(_)
        setup_codelens_refresh(_)
      end,
      severity_sort = true,
    })

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
          local default_diagnostic_handler = vim.lsp.handlers[method]
          vim.lsp.handlers[method] = function(err, result, context, config)
            if err ~= nil and err.code == -32802 then
              return
            end
            return default_diagnostic_handler(err, result, context, config)
          end
        end

        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(ev.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local lsp_opts = { noremap = true, silent = true, buffer = ev.buf }

        require("which-key").add({
          {
            "gD",
            function()
              vim.lsp.buf.declaration()
            end,
            desc = "go to declaration",
          },
          {
            "gd",
            function()
              Snacks.picker.lsp_definitions()
            end,
            desc = "go to definition(s) of symbol under cursor",
          },
          {
            "gt",
            function()
              Snacks.picker.lsp_type_definitions()
            end,
            desc = "go to definition(s) of the type of the symbol under cursor",
          },
          {
            "gr",
            function()
              Snacks.picker.lsp_references()
            end,
            desc = "search references to symbol under cursor",
          },
          {
            "gi",
            function()
              Snacks.picker.lsp_implementations()
            end,
            desc = "search implementations of the symbol under cursor",
          },
          {
            "<leader>st",
            function()
              Snacks.picker.lsp_workspace_symbols()
            end,
            desc = "LSP Workspace Symbols",
          },
          {
            "<leader>ss",
            function()
              Snacks.picker.lsp_symbols()
            end,
            desc = "LSP Symbols",
          },
          {
            "K",
            vim.lsp.buf.hover,
            desc = "show LSP diagnostic info in hover",
          },
          {
            "<C-k>",
            vim.lsp.buf.signature_help,
            desc = "show LSP signature help in hover",
          },
          {
            "<space>e",
            function()
              vim.cmd.RustLsp({ "renderDiagnostic", "current" })
            end,
            desc = "open LSP diagnostic float",
          },
          {
            "<space>q",
            ":lua vim.diagnostic.setloclist()<CR>",
            desc = "set the loclist with LSP diagnostics",
          },
        }, lsp_opts)

        -- Highlight word under cursor
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = ev.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = ev.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end
      end,
    })

    local lspconfig = require("lspconfig")
    local navic = require("nvim-navic")

    local on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end

      setup_codelens_refresh(client, bufnr)
    end

    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })

    lspconfig.pyright.setup({
      on_attach = on_attach,
      settings = {
        python = {
          defaultInterpreterPath = "/home/discord/.virtualenvs/discord_api/bin/python",
          terminal = {
            activateEnvironment = false,
            unittestEnabled = false,
          },
          analysis = {
            autoImportCompletions = true,
            indexing = true,
            userFileIndexingLimit = -1,
            typeCheckingMode = "off",
            diagnosticSeverityOverrides = {
              reportAssertAlwaysTrue = "warning",
              reportCallInDefaultInitializer = "warning",
              reportDuplicateImport = "warning",
              reportIncompatibleVariableOverride = "warning",
              reportInconsistentConstructor = "warning",
              reportInvalidStringEscapeSequence = "warning",
              reportInvalidStubStatement = "warning",
              reportMatchNotExhaustive = "warning",
              reportMissingParameterType = "warning",
              reportOptionalCall = "warning",
              reportOptionalContextManager = "warning",
              reportOptionalIterable = "warning",
              reportOptionalMemberAccess = "warning",
              reportOptionalOperand = "warning",
              reportOptionalSubscript = "warning",
              reportOverlappingOverload = "warning",
              reportPrivateImportUsage = "warning",
              reportPrivateUsage = "warning",
              reportPropertyTypeMismatch = "warning",
              reportSelfClsParameterName = "warning",
              reportShadowedImports = "warning",
              reportTypedDictNotRequiredAccess = "warning",
              reportUninitializedInstanceVariable = "warning",
              reportUnknownParameterType = "warning",
              reportUnnecessaryCast = "warning",
              reportUnnecessaryComparison = "warning",
              reportUnnecessaryContains = "warning",
              reportUnnecessaryIsInstance = "warning",
              reportUnsupportedDunderAll = "warning",
              reportUnusedClass = "warning",
              reportUnusedCoroutine = "warning",
              reportUnusedFunction = "warning",
              reportUnusedImport = "warning",
              reportUnusedVariable = "warning",
              reportWildcardImportFromLibrary = "warning",
            },
          },
        },
      },
    })
    -- lspconfig.mypy.setup {
    --   on_attach = on_attach,
    -- }
    lspconfig.ruff.setup({
      on_attach = on_attach,
      settings = {
        nativeServer = true,
      },
    })
    lspconfig.vtsls.setup({
      on_attach = on_attach,
    })
  end,
  dependencies = {
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
}
