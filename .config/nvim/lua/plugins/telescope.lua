local config_dir = vim.api.nvim_call_function("stdpath", { "config" })

return {
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.6",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>d", ":Telescope cder<CR>", desc = "change directory" },
      {
        "<leader>/",
        ":Telescope live_grep<CR>",
        desc = "live grep in current directory",
      },
      {
        "<leader><space>",
        ":Telescope find_files<CR>",
        desc = "find file in current directory",
      },
      { "<leader>fgc", ":Telescope git_commits<CR>", desc = "search commit history" },
      { "<leader>fgh", ":Telescope git_bcommits<CR>", desc = "search commit history for this buffer" },
      { "<leader>fh", ":Telescope help_tags<CR>", desc = "search neovim help tags" },

      { "<leader>fr", ":Telescope lsp_references<CR>", desc = "find references to symbol at cursor" },
      { "<leader>ft", ":Telescope lsp_dynamic_workspace_symbols<CR>", desc = "find LSP types" },

      {
        "<leader>fu",
        ":Telescope builtin<CR>",
        desc = "search other available telescope searches",
      },
      { "<leader>m", ":Telescope marks<CR>", desc = "search marks" },
      {
        ",",
        function()
          require("telescope.builtin").buffers({ sort_mru = true })
        end,
        desc = "search oldfiles",
      },
      -- {
      --   "<C-p>",
      --   function()
      --     require("telescope.builtin").buffers({ sort_mru = true })
      --   end,
      --   desc = "search oldfiles",
      -- },
      -- {
      --   "<C-n>",
      --   function()
      --     require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })
      --   end,
      --   desc = "search oldfiles",
      -- },
      {
        "<leader>cf",
        function()
          require("telescope.builtin").find_files({ cwd = config_dir })
        end,
        desc = "find config file",
      },
      {
        "<leader>fd/",
        function()
          local dir = vim.fn.input("Directory: ", "", "file")
          require("telescope.builtin").live_grep({ search_dirs = { dir } })
        end,
        desc = "live grep in specific directory",
      },
      {
        "<leader>fd<space>",
        function()
          local dir = vim.fn.input("Directory: ", "", "file")
          require("telescope.builtin").find_files({ search_dirs = { dir } })
        end,
        desc = "find file in specific directory",
      },
    },
    config = function()
      local actions = require("telescope.actions")
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = {
            height = 0.7,
          },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
          },
          color_devicons = true,
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
            "--hidden",
            "--glob",
            "!**/.git",
          },
        },
        pickers = {
          buffers = {
            layout_config = {
              height = 0.5,
            },
            previewer = false,
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              },
            },
          },
          jumplist = {
            mappings = {
              i = {
                ["<C-o>"] = actions.move_selection_previous,
                ["<C-i>"] = actions.move_selection_next,
              },
            },
            layout_config = {
              height = 0.9,
              width = 0.9,
              preview_height = 0.65,
            },
          },
          live_grep = {
            layout_strategy = "vertical",
            layout_config = {
              height = 0.9,
              width = 0.9,
            },
          },
          find_files = {
            previewer = false,
            find_command = {
              "fd",
              "--hidden",
              "--exclude",
              "**/.git",
              "--type",
              "file",
              "--type",
              "symlink",
              "--strip-cwd-prefix",
            },
          },
          diagnostics = {
            layout_strategy = "vertical",
          },
          lsp_references = {
            theme = "ivy",
            layout_strategy = "vertical",
            layout_config = {
              height = 0.9,
              width = 0.9,
            },
          },
        },
        extensions = {
          cder = {
            dir_command = { "fd", "--max-depth=4", "--type=d", ".", vim.g.start_directory },
            entry_maker = function(line)
              return {
                value = line,
                display = function(entry)
                  return "  " .. line:gsub(vim.g.start_directory .. "/", ""), { { { 1, 3 }, "Directory" } }
                end,
                ordinal = line,
              }
            end,
            previewer_command = "eza "
              .. "-a "
              .. "--color=always "
              .. "-T "
              .. "--level=3 "
              .. "--icons "
              .. "--git-ignore "
              .. "--long "
              .. "--no-permissions "
              .. "--no-user "
              .. "--no-filesize "
              .. "--git "
              .. "--ignore-glob=.git",
          },
        },
      })

      telescope.load_extension("cder")
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end,
  },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "Zane-/cder.nvim" },
  {
    "prochri/telescope-all-recent.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
    },
    opts = {
      scoring = {
        recency_modifier = {
          [1] = { age = 240, value = 100 }, -- past 4 hours
          [2] = { age = 1440, value = 90 }, -- past day
          [3] = { age = 4320, value = 80 }, -- past 3 days
          [4] = { age = 10080, value = 60 }, -- past week
          [5] = { age = 43200, value = 50 }, -- past month
          [6] = { age = 129600, value = 10 }, -- past 90 days
        },
        -- how much the score of a recent item will be improved.
        boost_factor = 0.0001,
      },
      default = {
        disable = true, -- disable any unkown pickers (recommended)
        use_cwd = true, -- differentiate scoring for each picker based on cwd
        sorting = "recent", -- sorting: options: 'recent' and 'frecency'
      },
      pickers = { -- allows you to overwrite the default settings for each picker
        find_files = {
          disable = false,
          sorting = "frecency",
        },
        ["cder#cder"] = {
          disable = false,
          use_cwd = false,
          sorting = "frecency",
        },
      },
    },
  },
}
