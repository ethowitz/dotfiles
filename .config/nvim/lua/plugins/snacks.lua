local curr_item = {}
local jumped_files = {}

function contains(table, item)
  for i = 1, #table do
    if table[i] == item then
      return true
    end
  end
  return false
end

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
  },
  keys = {
    {
      "<leader>ll",
      function()
        Snacks.picker.diagnostics({ severity = vim.diagnostic.severity.WARN })
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
        })
      end,
      desc = "Search files",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep({
          layout = {
            preset = "ivy_split",
          },
        })
      end,
      desc = "Live grep",
    },
    {
      ",",
      function()
        Snacks.picker.buffers({
          layout = {
            preview = false,
          },
        })
      end,
      desc = "Search buffers",
    },
    {
      "<C-p>",
      function()
        Snacks.picker.jumps({
          on_show = function(_)
            jumped_files = {}
          end,
          transform = function(item)
            if item.file == "" or contains(jumped_files, item.file) then
              return false
            else
              table.insert(jumped_files, item.file)
              item.text = item.file
              item.line = ""
              item.label = ""
              return item
            end
          end,
          win = {
            list = {
              keys = {
                ["<c-n>"] = { "list_up", mode = { "i", "n" } },
                ["<c-p>"] = { "list_down", mode = { "i", "n" } },
              },
            },
          },
          layout = {
            preset = "dropdown",
            hidden = { "input" },
            preview = false,
            layout = {
              height = 0.2,
            },
          },
          title = "Jumplist Files",
        })
      end,
      desc = "recent jumps, except only include the most recent jump in each file",
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
                  "-t",
                  "f",
                  "-t",
                  "s",
                  "-t",
                  "d",
                  "--follow",
                  "--base-directory",
                  vim.g.gitroot,
                  -- vim.fs.normalize("~/dev"),
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
          end,
          on_change = function(picker, item)
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
            history_bonus = false,
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
    -- {
    --   "<leader>sp",
    --   function()
    --     Snacks.picker.files({
    --       args = project_fd_args,
    --       confirm = function(picker, item)
    --         picker:close()
    --         Snacks.picker.pick("files", {
    --           dirs = { item.file },
    --         })
    --       end,
    --       title = "Find Files in Project",
    --       transform = function(item)
    --         item.dir = true
    --       end,
    --     })
    --   end,
    --   desc = "search recent projects",
    -- },
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
