-- TODO: when opening a file/buffer, open it in correct tab page
-- TODO: autocmd to set tab name to tab cwd

local curr_item = {}

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = {
      enabled = true,
    },
    bufdelete = {
      enabled = true,
    },
    picker = {
      enabled = true,
      layout = {
        preset = "ivy",
        layout = {
          height = 0.3,
        },
      },
      sources = {
        smart = {
          previewer = false,
        },
      },
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<c-n>"] = { "list_up", mode = { "i", "n" } },
            ["<c-p>"] = { "list_down", mode = { "i", "n" } },
          },
        },
      },
    },
    terminal = {
      enabled = true,
    },
  },
  keys = {
    {
      [[<C-\>]],
      function()
        local cwd = vim.fn["getcwd"]()
        Snacks.terminal.toggle(_, { cwd = cwd })
      end,
      desc = "Toggle the terminal",
    },
    {
      "<leader>ll",
      function()
        Snacks.picker.diagnostics({ severity = { min = vim.diagnostic.severity.WARN } })
      end,
    },
    {
      "<leader><space>",
      function()
        Snacks.picker.smart({
          layout = {
            preview = false,
          },
          multi = { "files" },
          formatters = {
            file = {
              truncate = 100,
            },
          },
          hidden = true,
          title = "Files",
        })
      end,
      desc = "Search files",
    },
    {
      "<leader>i",
      function()
        Snacks.picker.smart({
          layout = {
            preview = false,
          },
          multi = { "files" },
          formatters = {
            file = {
              truncate = 100,
            },
          },
          title = "Files (incl. ignored)",
          hidden = true,
          ignored = true,
        })
      end,
      desc = "Search files (incl. ignored)",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep({
          layout = {
            preset = "ivy_split",
          },
          title = "Live Grep",
          hidden = true,
        })
      end,
      desc = "Live grep",
    },
    {
      "<leader>?",
      function()
        Snacks.picker.grep({
          layout = {
            preset = "ivy_split",
          },
          hidden = true,
          ignored = true,
          title = "Live Grep (incl. ignored)",
        })
      end,
      desc = "Live grep (incl. ignored)",
    },
    {
      ",",
      function()
        Snacks.picker.buffers({
          filter = {
            cwd = true,
          },
          layout = {
            preset = "telescope",
            hidden = { "input" },
            preview = false,
            reverse = false,
            layout = {
              height = 0.2,
              width = 0.6,
            },
          },
        })
      end,
      desc = "Search buffers",
    },
    {
      "<M-p>",
      function()
        Snacks.picker.recent({
          win = {
            list = {
              title = "Recent Files (global)",
              keys = {
                ["<C-n>"] = nil,
                ["<C-p>"] = nil,
                ["<M-n>"] = { "list_up", mode = { "i", "n" } },
                ["<M-p>"] = { "list_down", mode = { "i", "n" } },
              },
            },
          },
          layout = {
            preset = "telescope",
            hidden = { "input" },
            preview = false,
            reverse = false,
            layout = {
              height = 0.2,
              width = 0.6,
            },
          },
        })
      end,
    },
    {
      "<C-p>",
      function()
        Snacks.picker.recent({
          filter = {
            cwd = true,
          },
          win = {
            list = {
              title = "Recent Files",
              keys = {
                ["<C-n>"] = { "list_up", mode = { "i", "n" } },
                ["<C-p>"] = { "list_down", mode = { "i", "n" } },
              },
            },
          },
          layout = {
            preset = "telescope",
            hidden = { "input" },
            preview = false,
            reverse = false,
            layout = {
              height = 0.2,
              width = 0.6,
            },
          },
        })
      end,
    },
    {
      "<leader>sP",
      function()
        Snacks.picker.pickers()
      end,
      desc = "Search pickers",
    },
    {
      "<leader>p",
      function()
        Snacks.picker.files({
          args = {},
          -- We need to define our own finder here since Snacks includes "-E .git" as an argument
          -- by default, and we specifically want to search for that directory. This logic is
          -- derived from snacks.picker.source.files()
          finder = function(opts, ctx)
            local uv = vim.uv or vim.loop

            local cwd = not (opts.rtp or (opts.dirs and #opts.dirs > 0))
                and vim.fs.normalize(opts and opts.cwd or uv.cwd() or ".")
              or nil
            return require("snacks.picker.source.proc").proc({
              opts,
              {
                cmd = "fd",
                args = {
                  "--unrestricted", -- include ignored and hidden files
                  "--exclude",
                  "node_modules",
                  "--exclude",
                  "bazel-*",
                  "-t",
                  "f",
                  "-t",
                  "s",
                  "-t",
                  "d",
                  "--follow",
                  "--base-directory",
                  vim.fs.normalize("~/dev"),
                  "--strip-cwd-prefix",
                  "--glob",
                  "{.git,.projectroot}",
                  "-x",
                  "dirname",
                  "{}",
                },
                notify = not opts.live,
                transform = function(item)
                  item.cwd = cwd
                  item.file = item.text
                end,
              },
            }, ctx)
          end,
          confirm = function(picker, item)
            picker:close()
            local cd_path = vim.fs.joinpath(vim.g.gitroot, item.text)
            Snacks.picker.actions.tcd(_, cd_path)
            vim.cmd("Tabby rename_tab " .. vim.fs.basename(cd_path))
          end,
          on_change = function(_, item)
            curr_item = item
          end,
          on_show = function()
            curr_item = nil
          end,
          title = "Change Project",
          transform = function(item)
            item.dir = true
          end,
          layout = {
            preset = "dropdown",
            preview = false,
            layout = {
              height = 0.2,
            },
          },
          matcher = {
            -- cwd_bonus = true,
            frecency = true,
            sort_empty = true,
            history_bonus = true,
          },
          win = {
            input = {
              keys = {
                -- open a new tab and tcd to the curr selected item
                ["<c-t>"] = {
                  function(picker)
                    -- TODO: maybe there's a better way to do this? I have no idea what functions
                    -- are callable on picker, but it doesn't appear to be the ones that are
                    -- documented
                    vim.cmd("tabnew")
                    local cd_path = vim.fs.joinpath(vim.g.gitroot, curr_item.text)
                    vim.cmd("Tabby rename_tab " .. vim.fs.basename(cd_path))
                    -- TODO: install better tabline plugin
                    -- name the tabs after the tcd
                    -- always open in new tab unless use special keystroke
                    Snacks.picker.actions.tcd(_, cd_path)
                    picker:close()
                  end,
                  mode = { "n", "i" },
                },
              },
            },
          },
        })
      end,
      desc = "Search recent projects",
    },
    {
      "<leader>cf",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Search config files",
    },
    {
      "<leader>sW",
      function()
        Snacks.picker.grep_word({
          layout = {
            preset = "ivy_split",
          },
        })
      end,
      desc = "Find current word",
      mode = { "n", "x" },
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help({
          layout = {
            preset = "ivy_split",
          },
        })
      end,
      desc = "Find neovim help page",
      mode = { "n", "x" },
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps({
          layout = {
            preview = false,
          },
        })
      end,
      desc = "Search keymappings",
      mode = { "n", "x" },
    },
    {
      "<leader>sq",
      function()
        Snacks.picker.qflist({
          layout = {
            preset = "ivy_split",
          },
        })
      end,
      desc = "Search quickfixes",
    },
    {
      "<leader>su",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo History",
    },
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log({
          layout = {
            preset = "ivy_split",
          },
          confirm = function(picker, item)
            vim.cmd("DiffviewOpen " .. item.commit .. "^!")
            picker:close()
          end,
        })
      end,
      desc = "git log",
    },
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log_line({
          layout = {
            preset = "ivy_split",
          },
          confirm = function(picker, item)
            vim.cmd("DiffviewOpen " .. item.commit .. "^! -- " .. item.file)
            picker:close()
          end,
        })
      end,
      desc = "git log line",
    },
    {
      "<leader>gf",
      function()
        Snacks.picker.git_log_file({
          layout = {
            preset = "ivy_split",
          },
          confirm = function(picker, item)
            vim.cmd("DiffviewOpen " .. item.commit .. "^! -- " .. item.file)
            picker:close()
          end,
        })
      end,
      desc = "git log file",
    },
    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto T[y]pe Definition",
    },
  },
}
