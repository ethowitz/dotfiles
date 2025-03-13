local project_patterns = {
  "Cargo.toml",
  "requirements.txt",
  "requirements.ini",
  "Gemfile",
  "build.sbt",
  "Makefile",
  "BUILD",
  "main.tf",
}

local project_fd_args = {
  "-H",
  "-t",
  "f",
  "-t",
  "s",
  "-t",
  "d",
  "--follow",
  "--strip-cwd-prefix",
  "--base-directory",
  vim.g.start_directory,
  "-g",
  "{" .. table.concat(project_patterns, ",") .. "}",
  "-x",
  "dirname",
  "{}",
}

local timer = nil

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
      "<leader><space>",
      function()
        Snacks.picker.smart({
          layout = {
            preview = false,
          },
          multi = { "files" },
        })
      end,
      desc = "search files",
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
      desc = "live grep",
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
      desc = "search buffer",
    },
    {
      "<C-o>",
      function()
        Snacks.picker.jumps({
          on_change = function(picker)
            if timer then
              timer:stop()
            end

            local close_picker = function()
              Snacks.picker.actions.close(picker)
            end
            timer = vim.loop.new_timer()
            timer:start(500, 0, vim.schedule_wrap(close_picker))
            Snacks.picker.actions.jump(picker, _, { cmd = nil })
            Snacks.picker.actions.focus_list(picker)
          end,
          auto_close = false,
          jump = {
            close = false,
            reuse_win = true,
          },
          win = {
            list = {
              keys = {
                ["<C-o>"] = "list_down",
                ["<c-i>"] = "list_up",
              },
            },
          },
          layout = {
            max_height = 10,
          },
        })
      end,
      desc = "search jumps",
    },
    {
      "<C-p>",
      function()
        Snacks.picker.recent()
      end,
      desc = "search recent files",
    },
    {
      "<leader>cp",
      function()
        Snacks.picker.files({
          args = project_fd_args,
          confirm = function(picker, item)
            picker:close()
            Snacks.picker.actions.cd(_, item.text)
          end,
          title = "Change Project",
          transform = function(item)
            item.dir = true
          end,
          layout = {
            preview = false,
          },
        })
      end,
      desc = "change project",
    },
    -- {
    --   "<leader>cd",
    --   function()
    --     Snacks.picker.files({
    --       args = {
    --         "-H",
    --         "-t",
    --         "d",
    --         "--follow",
    --         "--strip-cwd-prefix",
    --         "--base-directory",
    --         vim.g.start_directory,
    --       },
    --       confirm = function(picker, item)
    --         picker:close()
    --         Snacks.picker.actions.cd(_, item.text)
    --       end,
    --       title = "Change Directory",
    --       transform = function(item)
    --         item.dir = true
    --       end,
    --       layout = {
    --         preview = false,
    --       },
    --     })
    --   end,
    --   desc = "change project",
    -- },
    {
      "<leader>sp",
      function()
        Snacks.picker.files({
          args = project_fd_args,
          confirm = function(picker, item)
            picker:close()
            Snacks.picker.pick("files", {
              dirs = { item.file },
            })
          end,
          title = "Find Files in Project",
          transform = function(item)
            item.dir = true
          end,
        })
      end,
      desc = "search recent projects",
    },
    {
      "<leader>cf",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config File",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word({
          layout = {
            preset = "ivy_split",
          },
        })
      end,
      desc = "search visual selection or word",
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
      desc = "search help",
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
      desc = "search keymappings",
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
      desc = "Quickfix List",
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
        Snacks.picker.git_log_line({
          layout = {
            preset = "ivy_split",
          },
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
